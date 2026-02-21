import type { Access, CollectionConfig } from 'payload'

import {
  canManageOwnContentAsPaidContributor,
  canPostAsPaidContributor,
  isAdminUser,
} from '../access/publishingAccess'

const slugify = (value: string): string =>
  value
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')

const ownerOrAdmin: Access = ({ req: { user } }) => {
  if (!user) return false
  if (isAdminUser(user)) return true
  return { owner: { equals: user.id } }
}
const manageBusinessDirectoryAccess = canManageOwnContentAsPaidContributor('owner')

const publicReadOrOwner: Access = ({ req: { user } }) => {
  if (isAdminUser(user)) return true

  const approvedAndActive = {
    status: { equals: 'approved' },
    isActive: { equals: true },
  }

  if (!user) return approvedAndActive

  return {
    or: [approvedAndActive, { owner: { equals: user.id } }],
  }
}

export const BusinessDirectory: CollectionConfig = {
  slug: 'business-directory',
  admin: {
    useAsTitle: 'name',
    defaultColumns: ['name', 'category', 'city', 'status', 'isActive', 'isFeatured'],
  },
  access: {
    read: publicReadOrOwner,
    create: canPostAsPaidContributor,
    update: manageBusinessDirectoryAccess,
    delete: manageBusinessDirectoryAccess,
  },
  hooks: {
    beforeValidate: [
      ({ data, req, operation }) => {
        if (!data) return data

        if (!data.slug && typeof data.name === 'string' && data.name.trim().length > 0) {
          data.slug = slugify(data.name)
        }

        if (operation === 'create' && req.user && !isAdminUser(req.user)) {
          data.owner = req.user.id
          data.status = 'pending'
          data.isFeatured = false
        }

        if (operation === 'update' && req.user && !isAdminUser(req.user)) {
          if ('status' in data) delete (data as Record<string, unknown>).status
          if ('isFeatured' in data) delete (data as Record<string, unknown>).isFeatured
        }

        return data
      },
    ],
  },
  fields: [
    {
      name: 'owner',
      type: 'relationship',
      relationTo: 'users',
      required: true,
      admin: {
        position: 'sidebar',
      },
    },
    {
      name: 'name',
      type: 'text',
      required: true,
    },
    {
      name: 'slug',
      type: 'text',
      required: true,
      unique: true,
      index: true,
      admin: {
        description: 'URL-friendly unique identifier',
      },
    },
    {
      name: 'category',
      type: 'select',
      required: true,
      options: [
        { label: 'Real Estate', value: 'real_estate' },
        { label: 'Hospitality', value: 'hospitality' },
        { label: 'Retail', value: 'retail' },
        { label: 'Professional Services', value: 'professional_services' },
        { label: 'Technology', value: 'technology' },
        { label: 'Finance', value: 'finance' },
        { label: 'Health', value: 'health' },
        { label: 'Education', value: 'education' },
        { label: 'Construction', value: 'construction' },
        { label: 'Agriculture', value: 'agriculture' },
        { label: 'Other', value: 'other' },
      ],
    },
    {
      name: 'subcategory',
      type: 'text',
    },
    {
      name: 'description',
      type: 'textarea',
      required: true,
    },
    {
      name: 'logo',
      type: 'upload',
      relationTo: 'media',
    },
    {
      name: 'gallery',
      type: 'upload',
      relationTo: 'media',
      hasMany: true,
    },
    {
      name: 'phone',
      type: 'text',
      required: true,
    },
    {
      name: 'email',
      type: 'email',
    },
    {
      name: 'website',
      type: 'text',
    },
    {
      name: 'address',
      type: 'text',
      required: true,
    },
    {
      name: 'city',
      type: 'text',
      required: true,
    },
    {
      name: 'district',
      type: 'text',
    },
    {
      name: 'country',
      type: 'text',
      defaultValue: 'Rwanda',
    },
    {
      name: 'geo',
      type: 'group',
      fields: [
        {
          name: 'latitude',
          type: 'number',
        },
        {
          name: 'longitude',
          type: 'number',
        },
      ],
    },
    {
      name: 'social',
      type: 'group',
      fields: [
        { name: 'facebook', type: 'text' },
        { name: 'instagram', type: 'text' },
        { name: 'linkedin', type: 'text' },
        { name: 'x', type: 'text' },
        { name: 'whatsapp', type: 'text' },
      ],
    },
    {
      name: 'businessHours',
      type: 'array',
      fields: [
        {
          name: 'day',
          type: 'select',
          required: true,
          options: [
            { label: 'Monday', value: 'monday' },
            { label: 'Tuesday', value: 'tuesday' },
            { label: 'Wednesday', value: 'wednesday' },
            { label: 'Thursday', value: 'thursday' },
            { label: 'Friday', value: 'friday' },
            { label: 'Saturday', value: 'saturday' },
            { label: 'Sunday', value: 'sunday' },
          ],
        },
        {
          name: 'openTime',
          type: 'text',
          admin: {
            condition: (_, siblingData) => !siblingData?.isClosed,
          },
        },
        {
          name: 'closeTime',
          type: 'text',
          admin: {
            condition: (_, siblingData) => !siblingData?.isClosed,
          },
        },
        {
          name: 'isClosed',
          type: 'checkbox',
          defaultValue: false,
        },
      ],
    },
    {
      name: 'services',
      type: 'array',
      fields: [
        {
          name: 'service',
          type: 'text',
        },
      ],
    },
    {
      name: 'tags',
      type: 'array',
      fields: [
        {
          name: 'tag',
          type: 'text',
        },
      ],
    },
    {
      name: 'status',
      type: 'select',
      required: true,
      defaultValue: 'pending',
      options: [
        { label: 'Pending Review', value: 'pending' },
        { label: 'Approved', value: 'approved' },
        { label: 'Rejected', value: 'rejected' },
      ],
      access: {
        update: ({ req: { user } }) => isAdminUser(user),
      },
      admin: {
        position: 'sidebar',
      },
    },
    {
      name: 'isFeatured',
      type: 'checkbox',
      defaultValue: false,
      access: {
        update: ({ req: { user } }) => isAdminUser(user),
      },
      admin: {
        position: 'sidebar',
      },
    },
    {
      name: 'isActive',
      type: 'checkbox',
      defaultValue: true,
      admin: {
        position: 'sidebar',
      },
    },
    {
      name: 'verificationNotes',
      type: 'textarea',
      access: {
        read: ({ req: { user } }) => isAdminUser(user),
        update: ({ req: { user } }) => isAdminUser(user),
      },
      admin: {
        description: 'Internal moderation notes',
      },
    },
    {
      name: 'viewCount',
      type: 'number',
      defaultValue: 0,
      admin: {
        readOnly: true,
        position: 'sidebar',
      },
    },
    {
      name: 'dateListed',
      type: 'date',
      defaultValue: () => new Date().toISOString(),
      admin: {
        position: 'sidebar',
      },
    },
  ],
  indexes: [
    {
      fields: ['slug'],
      unique: true,
    },
    {
      fields: ['category', 'city'],
    },
    {
      fields: ['status', 'isActive'],
    },
  ],
}
