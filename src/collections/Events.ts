import type { CollectionConfig } from 'payload'

import {
  isAdminUser,
} from '../access/publishingAccess'

const isAdmin = (user: any) => user?.role === 'admin'

export const Events: CollectionConfig = {
  slug: 'events',
  admin: {
    useAsTitle: 'title',
    defaultColumns: ['title', 'type', 'location', 'date', 'isFeatured'],
  },
  access: {
    read: () => true,
    create: () => true,
    update: () => true,
    delete: () => true,
  },
  hooks: {
    beforeValidate: [
      ({ data, req, operation }) => {
        if (!data) return data

        if (operation === 'create' && req.user && !isAdminUser(req.user)) {
          data.organizerId = req.user.id
        }

        if (operation === 'update' && req.user && !isAdminUser(req.user) && 'organizerId' in data) {
          delete (data as Record<string, unknown>).organizerId
        }

        return data
      },
    ],
  },
  fields: [
    {
      name: 'title',
      type: 'text',
      required: true,
    },
    {
      name: 'description',
      type: 'textarea',
      admin: {
        description: 'Event details',
      },
    },
    {
      name: 'type',
      type: 'select',
      required: true,
      options: [
        { label: 'Networking', value: 'networking' },
        { label: 'Seminar', value: 'seminar' },
        { label: 'Workshop', value: 'workshop' },
        { label: 'Conference', value: 'conference' },
      ],
    },
    {
      name: 'organizer',
      type: 'text',
      required: true,
    },
    {
      name: 'organizerId',
      type: 'relationship',
      relationTo: 'users',
      access: {
        create: ({ req: { user } }) => isAdminUser(user),
        update: ({ req: { user } }) => isAdminUser(user),
      },
      admin: {
        description: 'User who created this event',
      },
    },
    {
      name: 'location',
      type: 'text',
      required: true,
    },
    {
      name: 'venue',
      type: 'text',
    },
    {
      name: 'date',
      type: 'date',
      required: true,
      admin: {
        date: {
          pickerAppearance: 'dayAndTime',
        },
      },
    },
    {
      name: 'endDate',
      type: 'date',
      admin: {
        description: 'For multi-day events',
        date: {
          pickerAppearance: 'dayAndTime',
        },
      },
    },
    {
      name: 'image',
      type: 'upload',
      relationTo: 'media',
    },
    {
      name: 'capacity',
      type: 'number',
    },
    {
      name: 'price',
      type: 'number',
      defaultValue: 0,
      admin: {
        description: '0 = free event',
      },
    },
    {
      name: 'currency',
      type: 'text',
      defaultValue: 'USD',
    },
    {
      name: 'registrationUrl',
      type: 'text',
      admin: {
        description: 'External registration link',
      },
    },
    {
      name: 'isVirtual',
      type: 'checkbox',
      defaultValue: false,
    },
    {
      name: 'virtualLink',
      type: 'text',
      admin: {
        description: 'Zoom/Meet link for virtual events',
        condition: (data) => data?.isVirtual,
      },
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
      name: 'isFeatured',
      type: 'checkbox',
      defaultValue: false,
      access: {
        update: ({ req: { user } }) => isAdminUser(user),
      },
    },
  ],
}
