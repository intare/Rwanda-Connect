import type { Access, CollectionConfig } from 'payload'

const ownerOrAdmin: Access = ({ req: { user } }) => {
  if (!user) return false
  if (user.role === 'admin') return true
  return { user: { equals: user.id } }
}

export const Bookmarks: CollectionConfig = {
  slug: 'bookmarks',
  admin: {
    defaultColumns: ['user', 'entityType', 'entityId', 'createdAt'],
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
    },
    {
      name: 'entityType',
      type: 'select',
      required: true,
      options: [
        { label: 'Opportunity', value: 'opportunity' },
        { label: 'Event', value: 'event' },
        { label: 'News', value: 'news' },
        { label: 'Post', value: 'post' },
      ],
    },
    {
      name: 'entityId',
      type: 'text',
      required: true,
      admin: {
        description: 'ID of the bookmarked item',
      },
    },
  ],
  indexes: [
    {
      fields: ['user', 'entityType', 'entityId'],
      unique: true,
    },
  ],
}
