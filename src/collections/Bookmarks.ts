import type { CollectionConfig } from 'payload'

export const Bookmarks: CollectionConfig = {
  slug: 'bookmarks',
  admin: {
    defaultColumns: ['user', 'entityType', 'entityId', 'createdAt'],
  },
  access: {
    read: ({ req: { user } }) => {
      if (user) return true
      return false
    },
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
      name: 'unique_bookmark',
      fields: ['user', 'entityType', 'entityId'],
      unique: true,
    },
  ],
}
