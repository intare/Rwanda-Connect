import type { CollectionConfig } from 'payload'

// Helper to check if user is admin
const isAdmin = (user: { role?: string } | null | undefined) => user?.role === 'admin'

export const Media: CollectionConfig = {
  slug: 'media',
  access: {
    // Anyone can read media
    read: () => true,
    // Any authenticated user can create (or admin)
    create: ({ req: { user } }) => {
      if (!user) return false
      return true
    },
    // Any authenticated user can update their uploads, admin can update all
    update: ({ req: { user } }) => {
      if (!user) return false
      if (isAdmin(user)) return true
      return true
    },
    // Only admin can delete
    delete: ({ req: { user } }) => isAdmin(user),
  },
  fields: [
    {
      name: 'alt',
      type: 'text',
      required: true,
    },
  ],
  upload: {
    staticDir: 'media',
    mimeTypes: ['image/*', 'application/pdf'],
    imageSizes: [
      {
        name: 'thumbnail',
        width: 400,
        height: 300,
        position: 'centre',
      },
      {
        name: 'card',
        width: 768,
        height: 512,
        position: 'centre',
      },
    ],
  },
}
