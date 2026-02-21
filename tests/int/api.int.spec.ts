import { getPayload, Payload } from 'payload'
import config from '@/payload.config'

import { describe, it, beforeAll, expect } from 'vitest'

let payload: Payload

describe('API', () => {
  beforeAll(async () => {
    const payloadConfig = await config
    payload = await getPayload({ config: payloadConfig })
  })

  it('fetches users', async () => {
    const users = await payload.find({
      collection: 'users',
    })
    expect(users).toBeDefined()
  })

  it('creates a 14-day trial subscription when a user signs up', async () => {
    const email = `trial-user-${Date.now()}@example.com`

    const user = await payload.create({
      collection: 'users',
      draft: false,
      data: {
        email,
        password: 'Password123!',
        role: 'user',
        contributorStatus: 'pending',
      },
    })

    const subscriptions = await payload.find({
      collection: 'subscriptions',
      where: {
        user: {
          equals: user.id,
        },
      },
      limit: 1,
    })

    expect(subscriptions.totalDocs).toBe(1)

    const subscription = subscriptions.docs[0]
    expect(subscription.plan).toBe('trial')
    expect(subscription.status).toBe('active')
    expect(subscription.trialEndsAt).toBeDefined()
    expect(subscription.endDate).toBeDefined()

    const trialStart = new Date(subscription.startDate ?? user.createdAt)
    const trialEnd = new Date(subscription.trialEndsAt as string)
    const diffMs = trialEnd.getTime() - trialStart.getTime()
    const diffDays = Math.round(diffMs / (24 * 60 * 60 * 1000))

    expect(diffDays).toBeGreaterThanOrEqual(13)
    expect(diffDays).toBeLessThanOrEqual(15)
  })

  it('allows posting only for paid approved contributors', async () => {
    const adminUser = {
      id: -1,
      role: 'admin' as const,
      contributorStatus: 'approved' as const,
    }

    const createUser = async (emailPrefix: string) => {
      const user = await payload.create({
        collection: 'users',
        draft: false,
        data: {
          email: `${emailPrefix}-${Date.now()}@example.com`,
          password: 'Password123!',
          role: 'user',
          contributorStatus: 'pending',
        },
      })

      return { id: user.id, role: 'user' as const }
    }

    const setPaidSubscription = async (userId: number) => {
      const subscriptions = await payload.find({
        collection: 'subscriptions',
        user: adminUser,
        overrideAccess: false,
        where: {
          user: { equals: userId },
        },
        limit: 1,
      })

      expect(subscriptions.totalDocs).toBeGreaterThan(0)

      await payload.update({
        collection: 'subscriptions',
        id: subscriptions.docs[0].id,
        user: adminUser,
        overrideAccess: false,
        data: {
          plan: 'monthly',
          status: 'active',
          endDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
        },
      })
    }

    const pendingContributor = await createUser('pending-contributor')
    await setPaidSubscription(pendingContributor.id)

    await expect(
      payload.create({
        collection: 'events',
        user: pendingContributor,
        overrideAccess: false,
        data: {
          title: `Pending Contributor Event ${Date.now()}`,
          description: 'Should be blocked',
          type: 'workshop',
          organizer: 'Pending User',
          location: 'Kigali, Rwanda',
          date: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString(),
        },
      }),
    ).rejects.toThrow()

    const approvedContributor = await createUser('approved-contributor')
    await payload.update({
      collection: 'users',
      id: approvedContributor.id,
      user: adminUser,
      overrideAccess: false,
      data: {
        contributorStatus: 'approved',
      },
    })
    await setPaidSubscription(approvedContributor.id)

    const createdEvent = await payload.create({
      collection: 'events',
      user: approvedContributor,
      overrideAccess: false,
      data: {
        title: `Approved Contributor Event ${Date.now()}`,
        description: 'Should be allowed',
        type: 'workshop',
        organizer: 'Approved User',
        location: 'Kigali, Rwanda',
        date: new Date(Date.now() + 10 * 24 * 60 * 60 * 1000).toISOString(),
      },
    })

    expect(createdEvent.id).toBeDefined()
    const organizerId =
      typeof createdEvent.organizerId === 'object'
        ? createdEvent.organizerId?.id
        : createdEvent.organizerId
    expect(organizerId).toBe(approvedContributor.id)
  })

  it('blocks update and delete when contributor is no longer paid', async () => {
    const adminUser = {
      id: -1,
      role: 'admin' as const,
      contributorStatus: 'approved' as const,
    }

    const user = await payload.create({
      collection: 'users',
      draft: false,
      data: {
        email: `lifecycle-contributor-${Date.now()}@example.com`,
        password: 'Password123!',
        role: 'user',
        contributorStatus: 'approved',
      },
    })

    const actor = { id: user.id, role: 'user' as const }

    await payload.update({
      collection: 'users',
      id: user.id,
      user: adminUser,
      overrideAccess: false,
      data: {
        contributorStatus: 'approved',
      },
    })

    const subscriptions = await payload.find({
      collection: 'subscriptions',
      user: adminUser,
      overrideAccess: false,
      where: {
        user: { equals: user.id },
      },
      limit: 1,
    })

    expect(subscriptions.totalDocs).toBeGreaterThan(0)

    await payload.update({
      collection: 'subscriptions',
      id: subscriptions.docs[0].id,
      user: adminUser,
      overrideAccess: false,
      data: {
        plan: 'monthly',
        status: 'active',
        endDate: new Date(Date.now() + 20 * 24 * 60 * 60 * 1000).toISOString(),
      },
    })

    const event = await payload.create({
      collection: 'events',
      user: actor,
      overrideAccess: false,
      data: {
        title: `Lifecycle Event ${Date.now()}`,
        description: 'Created while paid and approved',
        type: 'seminar',
        organizer: 'Lifecycle User',
        location: 'Kigali, Rwanda',
        date: new Date(Date.now() + 4 * 24 * 60 * 60 * 1000).toISOString(),
      },
    })

    await payload.update({
      collection: 'subscriptions',
      id: subscriptions.docs[0].id,
      user: adminUser,
      overrideAccess: false,
      data: {
        status: 'cancelled',
        endDate: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString(),
      },
    })

    await expect(
      payload.update({
        collection: 'events',
        id: event.id,
        user: actor,
        overrideAccess: false,
        data: {
          title: `Lifecycle Event Updated ${Date.now()}`,
        },
      }),
    ).rejects.toThrow()

    await expect(
      payload.delete({
        collection: 'events',
        id: event.id,
        user: actor,
        overrideAccess: false,
      }),
    ).rejects.toThrow()
  })
})
