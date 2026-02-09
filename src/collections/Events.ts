import type { CollectionConfig } from 'payload'

export const Events: CollectionConfig = {
  slug: 'events',
  admin: {
    useAsTitle: 'title',
    defaultColumns: ['title', 'type', 'location', 'date', 'isFeatured'],
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: 'title',
      type: 'text',
      required: true,
    },
    {
      name: 'description',
      type: 'richText',
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
    },
  ],
}
