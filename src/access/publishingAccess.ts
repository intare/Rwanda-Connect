import type { Access, PayloadRequest, Where } from 'payload'

const paidPlans = ['monthly', 'yearly'] as const

type UserLike = {
  id?: number | string
  role?: string
  contributorStatus?: 'pending' | 'approved' | 'rejected' | string
}

export const isAdminUser = (user: UserLike | null | undefined): boolean => user?.role === 'admin'

const isDateInFutureOrNow = (value: unknown): boolean => {
  if (typeof value !== 'string') return false
  const timestamp = new Date(value).getTime()
  if (Number.isNaN(timestamp)) return false
  return timestamp >= Date.now()
}

const getContributorStatus = async (
  req: PayloadRequest,
  userId: number | string,
): Promise<'pending' | 'approved' | 'rejected' | null> => {
  const user = (await req.payload.findByID({
    collection: 'users',
    id: userId,
    req,
    user: req.user,
    overrideAccess: false,
    depth: 0,
  })) as { contributorStatus?: 'pending' | 'approved' | 'rejected' | null }

  return user.contributorStatus ?? null
}

const hasActivePaidSubscription = async (req: PayloadRequest, userId: number | string): Promise<boolean> => {
  const result = await req.payload.find({
    collection: 'subscriptions',
    req,
    user: req.user,
    overrideAccess: false,
    limit: 1,
    depth: 0,
    sort: '-endDate',
    where: {
      and: [
        { user: { equals: userId } },
        { status: { equals: 'active' } },
        { plan: { in: [...paidPlans] } },
      ],
    },
  })

  if (result.totalDocs < 1) return false

  const subscription = result.docs[0] as { endDate?: string | null }
  if (!subscription.endDate) return true

  return isDateInFutureOrNow(subscription.endDate)
}

export const canPostAsPaidContributor: Access = async ({ req }) => {
  const user = req.user as UserLike | undefined
  if (!user) return false
  if (isAdminUser(user)) return true

  if (!user.id) return false

  const contributorStatus = await getContributorStatus(req, user.id)
  if (contributorStatus !== 'approved') return false

  return hasActivePaidSubscription(req, user.id)
}

export const canManageOwnContentAsPaidContributor =
  (ownerField: string): Access =>
  async ({ req }) => {
    const user = req.user as UserLike | undefined
    if (!user) return false
    if (!user.id) return false
    if (isAdminUser(user)) return true

    const canPost = await canPostAsPaidContributor({ req } as Parameters<Access>[0])
    if (canPost !== true) return false

    return {
      [ownerField]: {
        equals: user.id,
      },
    } as Where
  }
