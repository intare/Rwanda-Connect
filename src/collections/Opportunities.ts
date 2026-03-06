import type { CollectionConfig } from 'payload'

const isAdmin = (user: { role?: string } | null | undefined) => user?.role === 'admin'

export const Opportunities: CollectionConfig = {
  slug: 'opportunities',
  admin: {
    useAsTitle: 'title',
    defaultColumns: ['title', 'type', 'company', 'location', 'deadline', 'isFeatured'],
  },
  access: {
    read: () => true,
    create: () => true,
    update: () => true,
    delete: () => true,
  },
  fields: [
    {
      name: 'type',
      type: 'select',
      required: true,
      options: [
        { label: 'Job', value: 'job' },
        { label: 'Investment', value: 'investment' },
        { label: 'Scholarship', value: 'scholarship' },
        { label: 'Tender', value: 'tender' },
      ],
    },
    {
      name: 'title',
      type: 'text',
      required: true,
    },
    {
      name: 'company',
      type: 'text',
      required: true,
    },
    {
      name: 'companyLogo',
      type: 'upload',
      relationTo: 'media',
    },
    {
      name: 'location',
      type: 'text',
      required: true,
    },
    {
      name: 'description',
      type: 'textarea',
      admin: {
        description: 'Full job/opportunity description',
      },
    },
    {
      name: 'requirements',
      type: 'array',
      fields: [
        {
          name: 'requirement',
          type: 'text',
        },
      ],
    },
    {
      name: 'salary',
      type: 'number',
      admin: {
        description: 'Annual salary (for jobs)',
      },
    },
    {
      name: 'salaryCurrency',
      type: 'text',
      defaultValue: 'USD',
    },
    {
      name: 'deadline',
      type: 'date',
      admin: {
        date: {
          pickerAppearance: 'dayOnly',
        },
      },
    },
    {
      name: 'applyUrl',
      type: 'text',
      required: true,
      admin: {
        description: 'External application link',
      },
    },
    {
      name: 'verified',
      type: 'checkbox',
      defaultValue: false,
    },
    {
      name: 'isFeatured',
      type: 'checkbox',
      defaultValue: false,
    },
    {
      name: 'datePosted',
      type: 'date',
      defaultValue: () => new Date().toISOString(),
    },
  ],
}
