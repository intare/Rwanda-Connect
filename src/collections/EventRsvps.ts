import type { Access, CollectionConfig } from 'payload'

const ownerOrAdmin: Access = ({ req: { user } }) => {
  if (!user) return false
  if (user.role === 'admin') return true
  return { user: { equals: user.id } }
}

export const EventRsvps: CollectionConfig = {
  slug: 'event-rsvps',
  admin: {
    defaultColumns: ['event', 'user', 'status', 'createdAt'],
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
      name: 'event',
      type: 'relationship',
      relationTo: 'events',
      required: true,
    },
    {
      name: 'user',
      type: 'relationship',
      relationTo: 'users',
      required: true,
    },
    {
      name: 'status',
      type: 'select',
      required: true,
      defaultValue: 'going',
      options: [
        { label: 'Going', value: 'going' },
        { label: 'Interested', value: 'interested' },
        { label: 'Not Going', value: 'not_going' },
      ],
    },
  ],
  indexes: [
    {
      fields: ['event', 'user'],
      unique: true,
    },
  ],
}
