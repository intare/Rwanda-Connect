import type { CollectionConfig } from 'payload'

export const EventRsvps: CollectionConfig = {
  slug: 'event-rsvps',
  admin: {
    defaultColumns: ['event', 'user', 'status', 'createdAt'],
  },
  access: {
    read: () => true,
  },
  fields: [
    {
      name: 'event',
      type: 'relationship',
      relationTo: 'events',
      required: true,
    },
    {
      name: 'user',
      type: 'relationship',
      relationTo: 'users',
      required: true,
    },
    {
      name: 'status',
      type: 'select',
      required: true,
      defaultValue: 'going',
      options: [
        { label: 'Going', value: 'going' },
        { label: 'Interested', value: 'interested' },
        { label: 'Not Going', value: 'not_going' },
      ],
    },
  ],
  indexes: [
    {
      name: 'unique_event_rsvp',
      fields: ['event', 'user'],
      unique: true,
    },
  ],
}
