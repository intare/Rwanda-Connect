import type { Access, CollectionConfig } from 'payload'

const isAdmin = (user: { role?: string } | null | undefined) => user?.role === 'admin'
const enableEmailVerification =
  process.env.PAYLOAD_ENABLE_EMAIL_VERIFICATION === 'true' || process.env.NODE_ENV === 'production'
const trialDurationDays = 14

const adminOrSelf: Access = ({ req: { user } }) => {
  if (!user) return false
  if (isAdmin(user)) return true
  return { id: { equals: user.id } }
}

export const Users: CollectionConfig = {
  slug: 'users',
  admin: {
    useAsTitle: 'email',
  },
  auth: {
    verify: enableEmailVerification,
    maxLoginAttempts: 5,
    lockTime: 10 * 60 * 1000,
  },
  access: {
    create: () => true,
    read: adminOrSelf,
    update: adminOrSelf,
    delete: ({ req: { user } }) => isAdmin(user),
    admin: ({ req: { user } }) => isAdmin(user),
  },
  hooks: {
    beforeValidate: [
      ({ data, req, operation }) => {
        if (!data) return data
        if (operation === 'create' && !isAdmin(req.user)) {
          data.role = 'user'
          data.contributorStatus = 'pending'
        }
        if (operation === 'update' && !isAdmin(req.user) && 'role' in data) {
          delete (data as Record<string, unknown>).role
        }
        if (operation === 'update' && !isAdmin(req.user) && 'contributorStatus' in data) {
          delete (data as Record<string, unknown>).contributorStatus
        }
        return data
      },
    ],
    afterChange: [
      async ({ doc, operation, req }) => {
        if (operation !== 'create') return doc

        const startDate = new Date()
        const trialEndsAt = new Date(startDate)
        trialEndsAt.setDate(trialEndsAt.getDate() + trialDurationDays)

        try {
          await req.payload.create({
            collection: 'subscriptions',
            req,
            data: {
              user: doc.id,
              plan: 'trial',
              status: 'active',
              startDate: startDate.toISOString(),
              endDate: trialEndsAt.toISOString(),
              trialEndsAt: trialEndsAt.toISOString(),
            },
          })
        } catch (error) {
          const message = error instanceof Error ? error.message : ''
          const isDuplicateUserSubscription =
            message.includes('duplicate key value') &&
            message.includes('subscriptions') &&
            message.includes('user')

          if (!isDuplicateUserSubscription) {
            throw error
          }
        }

        return doc
      },
    ],
  },
  fields: [
    {
      name: 'role',
      type: 'select',
      options: [
        { label: 'User', value: 'user' },
        { label: 'Admin', value: 'admin' },
      ],
      defaultValue: 'user',
      required: true,
      saveToJWT: true,
      access: {
        create: ({ req: { user } }) => isAdmin(user),
        update: ({ req: { user } }) => isAdmin(user),
        read: ({ req: { user }, doc }) => isAdmin(user) || user?.id === doc?.id,
      },
      admin: {
        description: 'User role for access control',
      },
    },
    {
      name: 'name',
      type: 'text',
    },
    {
      name: 'contributorStatus',
      type: 'select',
      options: [
        { label: 'Pending', value: 'pending' },
        { label: 'Approved', value: 'approved' },
        { label: 'Rejected', value: 'rejected' },
      ],
      defaultValue: 'pending',
      required: true,
      saveToJWT: true,
      access: {
        create: ({ req: { user } }) => isAdmin(user),
        update: ({ req: { user } }) => isAdmin(user),
        read: ({ req: { user }, doc }) => isAdmin(user) || user?.id === doc?.id,
      },
      admin: {
        description: 'Contributor approval required for posting events, real estate, and business listings',
      },
    },
    {
      name: 'location',
      type: 'text',
    },
    {
      name: 'interests',
      type: 'array',
      fields: [
        {
          name: 'interest',
          type: 'text',
        },
      ],
    },
    {
      name: 'onboardingCompleted',
      type: 'checkbox',
      defaultValue: false,
    },
  ],
}
