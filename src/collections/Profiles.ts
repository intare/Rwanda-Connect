import type { Access, CollectionConfig } from 'payload'

const isAdmin = (user: { role?: string } | null | undefined) => user?.role === 'admin'

const ownerOrAdmin: Access = ({ req: { user } }) => {
  if (!user) return false
  if (isAdmin(user)) return true
  return { user: { equals: user.id } }
}

export const Profiles: CollectionConfig = {
  slug: 'profiles',
  admin: {
    useAsTitle: 'name',
    defaultColumns: ['name', 'email', 'location', 'onboardingCompleted'],
  },
  access: {
    read: () => true,
    create: ({ req: { user } }) => Boolean(user),
    update: ownerOrAdmin,
    delete: ownerOrAdmin,
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
