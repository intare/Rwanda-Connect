import type { Access, CollectionConfig } from 'payload'

const ownerOrAdmin: Access = ({ req: { user } }) => {
  if (!user) return false
  if (user.role === 'admin') return true
  return { user: { equals: user.id } }
}

export const Subscriptions: CollectionConfig = {
  slug: 'subscriptions',
  admin: {
    useAsTitle: 'plan',
    defaultColumns: ['user', 'plan', 'status', 'startDate', 'endDate'],
  },
  access: {
    read: ownerOrAdmin,
    create: ({ req: { user } }) => Boolean(user),
    update: ownerOrAdmin,
    delete: ownerOrAdmin,
  },
  hooks: {
    beforeValidate: [
      ({ data, req, operation }) => {
        if (!data) return data
        if (operation === 'create' && req.user && req.user.role !== 'admin') {
          data.user = req.user?.id
        }
        return data
      },
    ],
  },
  fields: [
    {
      name: 'user',
      type: 'relationship',
      relationTo: 'users',
      required: true,
      unique: true,
    },
    {
      name: 'plan',
      type: 'select',
      required: true,
      defaultValue: 'free',
      options: [
        { label: 'Free', value: 'free' },
        { label: 'Trial', value: 'trial' },
        { label: 'Monthly', value: 'monthly' },
        { label: 'Yearly', value: 'yearly' },
      ],
    },
    {
      name: 'status',
      type: 'select',
      required: true,
      defaultValue: 'active',
      options: [
        { label: 'Active', value: 'active' },
        { label: 'Expired', value: 'expired' },
        { label: 'Cancelled', value: 'cancelled' },
      ],
    },
    {
      name: 'billingProvider',
      type: 'select',
      options: [
        { label: 'Stripe', value: 'stripe' },
        { label: 'App Store', value: 'app_store' },
        { label: 'Play Store', value: 'play_store' },
        { label: 'Mobile Money', value: 'mobile_money' },
      ],
    },
    {
      name: 'externalSubscriptionId',
      type: 'text',
      admin: {
        description: 'ID from payment provider',
      },
    },
    {
      name: 'startDate',
      type: 'date',
      defaultValue: () => new Date().toISOString(),
    },
    {
      name: 'endDate',
      type: 'date',
    },
    {
      name: 'trialEndsAt',
      type: 'date',
    },
  ],
}
