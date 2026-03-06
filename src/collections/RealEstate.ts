import type { CollectionConfig } from 'payload'

import {
  isAdminUser,
} from '../access/publishingAccess'

const isAdmin = (user: any) => user?.role === 'admin'

export const RealEstate: CollectionConfig = {
  slug: 'real-estate',
  admin: {
    useAsTitle: 'title',
    defaultColumns: ['title', 'category', 'listingType', 'price', 'location', 'isFeatured'],
  },
  access: {
    read: () => true,
    create: ({ req: { user } }) => isAdmin(user),
    update: ({ req: { user } }) => isAdmin(user),
    delete: ({ req: { user } }) => isAdmin(user),
  },
  hooks: {
    beforeValidate: [
      ({ data, req, operation }) => {
        if (!data) return data

        if (operation === 'create' && req.user && !isAdminUser(req.user)) {
          data.owner = req.user.id
        }

        if (operation === 'update' && req.user && !isAdminUser(req.user) && 'owner' in data) {
          delete (data as Record<string, unknown>).owner
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
      admin: {
        position: 'sidebar',
      },
    },
    {
      name: 'title',
      type: 'text',
      required: true,
    },
    {
      name: 'category',
      type: 'select',
      required: true,
      options: [
        { label: 'House', value: 'house' },
        { label: 'Apartment', value: 'apartment' },
        { label: 'Land', value: 'land' },
      ],
    },
    {
      name: 'listingType',
      type: 'select',
      required: true,
      defaultValue: 'sale',
      options: [
        { label: 'For Sale', value: 'sale' },
        { label: 'For Rent', value: 'rent' },
      ],
    },
    {
      name: 'description',
      type: 'textarea',
    },
    {
      name: 'price',
      type: 'number',
      required: true,
      min: 0,
    },
    {
      name: 'currency',
      type: 'text',
      defaultValue: 'USD',
    },
    {
      name: 'location',
      type: 'text',
      required: true,
    },
    {
      name: 'areaSqm',
      type: 'number',
      min: 0,
      admin: {
        description: 'Total area in square meters',
      },
    },
    {
      name: 'bedrooms',
      type: 'number',
      min: 0,
      admin: {
        condition: (data) => data?.category !== 'land',
      },
    },
    {
      name: 'bathrooms',
      type: 'number',
      min: 0,
      admin: {
        condition: (data) => data?.category !== 'land',
      },
    },
    {
      name: 'images',
      type: 'upload',
      relationTo: 'media',
      hasMany: true,
    },
    {
      name: 'contactPhone',
      type: 'text',
    },
    {
      name: 'contactEmail',
      type: 'email',
    },
    {
      name: 'isFeatured',
      type: 'checkbox',
      defaultValue: false,
      access: {
        update: ({ req: { user } }) => isAdminUser(user),
      },
    },
    {
      name: 'isAvailable',
      type: 'checkbox',
      defaultValue: true,
    },
    {
      name: 'datePosted',
      type: 'date',
      defaultValue: () => new Date().toISOString(),
    },
  ],
}
