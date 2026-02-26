import type { CollectionConfig } from 'payload'

const isAdmin = (user: { role?: string } | null | undefined) => user?.role === 'admin'

export const Media: CollectionConfig = {
  slug: 'media',
  access: {
    // Anyone can read/view media
    read: () => true,
    // Only authenticated users can upload
    create: ({ req: { user } }) => Boolean(user),
    // Only authenticated users can update
    update: ({ req: { user } }) => Boolean(user),
    // Only admins can delete
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
