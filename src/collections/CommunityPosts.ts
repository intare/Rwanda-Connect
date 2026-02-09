import type { CollectionConfig } from 'payload'

export const CommunityPosts: CollectionConfig = {
  slug: 'community-posts',
  admin: {
    useAsTitle: 'content',
    defaultColumns: ['content', 'author', 'isPinned', 'createdAt'],
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: 'author',
      type: 'relationship',
      relationTo: 'users',
      required: true,
    },
    {
      name: 'content',
      type: 'textarea',
      required: true,
    },
    {
      name: 'isPinned',
      type: 'checkbox',
      defaultValue: false,
    },
    {
      name: 'likesCount',
      type: 'number',
      defaultValue: 0,
      admin: {
        readOnly: true,
      },
    },
    {
      name: 'commentsCount',
      type: 'number',
      defaultValue: 0,
      admin: {
        readOnly: true,
      },
    },
  ],
}
