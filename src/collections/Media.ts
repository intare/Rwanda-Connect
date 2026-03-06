import type { CollectionConfig } from 'payload'

export const Media: CollectionConfig = {
  slug: 'media',
  admin: {
    // Allow all authenticated users to manage media in admin panel
    hidden: false,
  },
  access: {
    // Media access is open for all operations
    read: () => true,
    create: ({ req }) => {
      // Allow anyone (authenticated or not) to upload
      return true
    },
    update: () => true,
    delete: () => true,
    admin: ({ req }) => {
      // Allow any authenticated user to access media in admin
      return Boolean(req.user)
    },
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
