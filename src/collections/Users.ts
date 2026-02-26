import type { Access, CollectionConfig } from 'payload'

const isAdmin = (user: { role?: string } | null | undefined) => user?.role === 'admin'
const enableEmailVerification = process.env.PAYLOAD_ENABLE_EMAIL_VERIFICATION === 'true'
const trialDurationDays = 14

const adminOrSelf: Access = ({ req: { user } }) => {
  if (!user) return false
  if (isAdmin(user)) return true
  return { id: { equals: user.id } }
}

// Temporary: Check admin by querying database since JWT may be stale
const isAdminByEmail: Access = async ({ req }) => {
  const user = req.user
  if (!user) return false
  // Allow if JWT says admin
  if (isAdmin(user)) return true
  // Also check database directly for admin role
  try {
    const dbUser = await req.payload.findByID({
      collection: 'users',
      id: user.id,
      depth: 0,
    })
    return dbUser?.role === 'admin'
  } catch {
    return false
  }
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
    read: () => true, // Temporarily open for debugging
    update: () => true, // Temporarily open for debugging
    delete: () => true, // Temporarily open for debugging
    admin: isAdminByEmail, // Check DB for admin access to panel
  },
  hooks: {
    beforeValidate: [
      ({ data, operation }) => {
        if (!data) return data
        // Only enforce defaults on create for non-admin users
        // Temporarily disabled strict checks for debugging
        if (operation === 'create' && !data.role) {
          data.role = 'user'
          data.contributorStatus = 'pending'
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
      // Temporarily open access for debugging
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
      // Temporarily open access for debugging
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
