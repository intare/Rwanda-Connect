import type { CollectionConfig } from 'payload'

export const Users: CollectionConfig = {
  slug: 'users',
  admin: {
    useAsTitle: 'email',
  },
  auth: true,
  access: {
    // Allow public registration
    create: () => true,
    // Users can read their own data
    read: ({ req: { user } }) => {
      if (user) {
        return { id: { equals: user.id } }
      }
      return false
    },
    // Users can update their own data
    update: ({ req: { user } }) => {
      if (user) {
        return { id: { equals: user.id } }
      }
      return false
    },
    // Only admins can delete
    delete: () => false,
  },
  fields: [
    {
      name: 'name',
      type: 'text',
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
