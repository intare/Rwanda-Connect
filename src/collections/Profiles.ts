import type { CollectionConfig } from 'payload'

export const Profiles: CollectionConfig = {
  slug: 'profiles',
  admin: {
    useAsTitle: 'name',
    defaultColumns: ['name', 'email', 'location', 'onboardingCompleted'],
  },
  access: {
    read: () => true,
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
      name: 'name',
      type: 'text',
      required: true,
    },
    {
      name: 'email',
      type: 'email',
      required: true,
    },
    {
      name: 'avatar',
      type: 'upload',
      relationTo: 'media',
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
