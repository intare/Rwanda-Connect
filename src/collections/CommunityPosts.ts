import type { Access, CollectionConfig } from 'payload'

const isAdmin = (user: { role?: string } | null | undefined) => user?.role === 'admin'

const authorOrAdmin: Access = ({ req: { user } }) => {
  if (!user) return false
  if (isAdmin(user)) return true
  return { author: { equals: user.id } }
}

export const CommunityPosts: CollectionConfig = {
  slug: 'community-posts',
  admin: {
    useAsTitle: 'content',
    defaultColumns: ['content', 'author', 'isPinned', 'createdAt'],
  },
  access: {
    read: () => true,
    create: ({ req: { user } }) => Boolean(user),
    update: authorOrAdmin,
    delete: authorOrAdmin,
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
