# Rwanda Connect PRD

## 1. Overview
Rwanda Connect is a mobile-first web app that connects the Rwandan diaspora to opportunities, community, events, and property listings back home. The current codebase is a React single-page app with static data and simulated flows. This PRD defines the intended product behavior and expands missing requirements needed for a production release.

## 2. Problem Statement
Diaspora users struggle to discover trustworthy opportunities, credible community connections, and actionable ways to invest or engage with Rwanda. Information is fragmented across sources and often lacks verification, context, or clear next steps.

## 3. Goals
- Centralize trusted opportunities (jobs, investments, scholarships, tenders) in one place.
- Build a credible, high-signal community space for networking and mentorship.
- Enable event discovery and participation across global diaspora hubs.
- Make Rwanda real estate discoverable with clear intent actions (bid, buy, contact).
- Convert engaged users into paid subscribers for premium value.

## 4. Success Metrics
- Activation: percent of new users who complete onboarding and reach the Home dashboard.
- Engagement: weekly active users, average session length, bookmarks per user.
- Opportunity actions: clicks to apply, saves, and outbound leads.
- Community actions: discussion participation, mentorship connects, group joins.
- Events: registrations, new events created, event attendance intent.
- Properties: detail views, bids placed, contact agent actions.
- Revenue: trial to paid conversion, paid churn rate.

## 5. Non-Goals
- Building a full social network or real-time chat in MVP.
- Handling real transactions for property purchase in MVP.
- Supporting offline-first functionality in MVP.
- Replacing embassy or government systems; the app is a discovery and engagement layer.

## 6. Target Users and Personas
- Diaspora Professional: seeks jobs, career growth, and verified opportunities.
- Diaspora Investor: looks for vetted investments and real estate options.
- Student or Graduate: seeks scholarships and career playbooks.
- Community Organizer: hosts events and builds local diaspora groups.
- Rwanda-based Partner: posts opportunities and engages diaspora talent.

## 7. Primary User Journeys
- New user registers, completes onboarding, selects a plan, and reaches Home.
- Returning user logs in, searches opportunities, and bookmarks items.
- User explores Properties, views details, and places a bid or contacts agent.
- User browses Events, filters by location/type, and registers.
- User joins Community, engages in discussions, and requests mentorship.

## 8. Module Requirements (Current vs Target)

### 8.1 Authentication and Profile
| Current | Target |
| --- | --- |
| Login and register with in-memory users. | Real authentication (email + password or SSO). |
| Profile editing with avatar and interests. | Password reset and email verification. |
| N/A | Persistent profile storage and updates. |
| N/A | User roles (admin, moderator, organizer, standard). |
| N/A | Privacy settings for profile visibility. |

Target MVP:
- Email/password auth with login/logout.
- Persist basic profile fields (name, email, location, interests).
- Basic session persistence (remembered login).

### 8.2 Onboarding and Welcome
| Current | Target |
| --- | --- |
| Welcome screen for new users with simple stats. | Onboarding questions to personalize content (interests, location, goals). |
| N/A | Content personalization pipeline based on onboarding data. |
| N/A | Ability to skip and resume onboarding. |

Target MVP:
- Capture interests and location.
- Allow skip and complete later.

### 8.3 Subscription and Billing
| Current | Target |
| --- | --- |
| Free trial and paid plan selection with simulated payment. | Real payment processing for cards, mobile money, and PayPal. |
| N/A | Billing portal (upgrade, downgrade, cancel, receipt history). |
| N/A | Plan entitlements and feature gating across the app. |
| N/A | Trial expiration handling and renewal flows. |

Target MVP:
- Free tier and trial state persisted on user profile.
- Basic gating for one key action (example: opportunity applications).

### 8.4 Home Dashboard and News
| Current | Target |
| --- | --- |
| Recent news cards and static upcoming events. | News API or CMS integration with editorial workflow. |
| N/A | News detail views and sharing. |
| N/A | Personalized feed based on user interests. |
| N/A | Content caching and read state tracking. |

Target MVP:
- News list fed by manual JSON or lightweight endpoint.
- News item opens detail or outbound link (no personalization).

### 8.5 Opportunities Marketplace
| Current | Target |
| --- | --- |
| Search, filter, sort, and bookmark static opportunities. | Backend listings with verified sources. |
| N/A | Opportunity detail view with clear apply actions. |
| N/A | Application tracking (status, deadlines, reminders). |
| N/A | Employer or partner portal to post and manage listings. |
| N/A | Fraud prevention and verification workflows. |

Target MVP:
- Opportunity list with filters and detail view.
- Apply action links out to the source.

### 8.6 Career Playbook
| Current | Target |
| --- | --- |
| Static content list with categories and featured items. | Content detail pages and deep links. |
| N/A | CMS-backed content with author management. |
| N/A | Premium content gating. |
| N/A | Save, like, and share actions with persistence. |

Target MVP:
- Not in MVP (Phase 2+).

### 8.7 Community
| Current | Target |
| --- | --- |
| Static discussions, events, mentorship, and groups. | Discussion creation, moderation, and reporting. |
| N/A | Mentorship request and matching workflow. |
| N/A | Group membership, roles, and group moderation. |
| N/A | Search and filter across community content. |
| N/A | Safety tooling and community guidelines enforcement. |

Target MVP:
- Discussion list with simple text-only post creation.

### 8.8 Events
| Current | Target |
| --- | --- |
| Search and filter static events, local event creation. | Persistent event creation with organizer permissions. |
| N/A | Registration flow and attendee management. |
| N/A | Tickets, pricing, and refunds (if paid). |
| N/A | Calendar integration and reminders. |

Target MVP:
- Event list with search and filters.
- RSVP intent (no paid tickets, no self-serve creation).

### 8.9 Properties
| Current | Target |
| --- | --- |
| Property listing, filtering, details, bid placement. | Verified property listings and agent verification. |
| N/A | Real bidding flow with audit trail and notifications. |
| N/A | Booking viewings and document exchange. |
| N/A | Legal disclaimers and transaction guidance. |

Target MVP:
- Not in MVP (Phase 2+).

### 8.10 Global Search, Filters, and Bookmarks
| Current | Target |
| --- | --- |
| Search and filters are isolated by page and partial. | Global search across news, opportunities, events, and properties. |
| N/A | Unified filter panel with applied filter counts. |
| N/A | Saved filters and persistent bookmarks. |

Target MVP:
- Not in MVP (Phase 2+).

### 8.11 Notifications
| Current | Target |
| --- | --- |
| Static notification counter in header. | Real notification system (in-app + email + push). |
| N/A | User controls for notification preferences. |
| N/A | Notification history with read state and delivery status. |

Target MVP:
- Not in MVP (Phase 2+).

### 8.12 Admin and Moderation
| Current | Target |
| --- | --- |
| No admin UI or moderation workflows. | Admin portal for content management and approvals. |
| N/A | Moderation queues for community content and events. |
| N/A | Abuse reporting and escalation workflows. |

Target MVP:
- Not in MVP (Phase 2+).

## 9. Data Model (Logical)
- User: id, name, email, location, interests, role, profile photo.
- Subscription: plan, status, billing provider, start/end dates.
- Opportunity: type, title, company, location, salary, deadline, verified.
- NewsArticle: title, category, source, summary, tags, publish date.
- Event: title, organizer, location, time, capacity, price, tags.
- Property: type, status, price, location, agent, bids, images.
- Bookmark: userId, entityType, entityId.
- Notification: userId, type, payload, read state.
- Application: userId, opportunityId, status, timestamps.
- Bid: propertyId, userId, amount, status, timestamps.

## 10. Non-Functional Requirements
- Performance: first contentful paint under 3 seconds on mid-tier mobile.
- Availability: 99.5 percent uptime for core APIs.
- Security: secure auth, encrypted data at rest and in transit.
- Privacy: GDPR and local compliance, user data export and deletion.
- Accessibility: WCAG 2.1 AA for key flows.
- Localization: English first, Kinyarwanda and French roadmap.
- Analytics: event tracking for activation, conversions, and retention.

## 11. Dependencies and Integrations
- Auth provider (email or SSO).
- Payments (card and mobile money).
- CMS for news and playbook content.
- Email and push notifications.
- Maps or geocoding for events and properties.

## 12. Risks and Mitigations
- Trust risk for listings: require verification and clear source attribution.
- Low conversion to paid: improve onboarding and trial value.
- Content staleness: define ownership and publishing workflows.
- Community safety: moderation tooling and reporting processes.

## 13. Open Questions
- What partner organizations will provide verified opportunities and data?
- Which payment providers are required by target regions?
- What is the exact premium feature set and gating rules?
- What is the desired moderation policy and escalation process?
- Should properties and events require approval before publishing?

## 14. Phased Delivery
MVP:
- Auth with persistent users.
- Opportunities listing and detail views.
- Events discovery and registration.
- Basic community discussions.
- Subscription trial and basic gating.

Phase 2:
- Full CMS integration for news and playbook.
- Mentorship matching and group management.
- Property bidding workflow with notifications.
- Admin portal and moderation tooling.

Phase 3:
- Multi-language support.
- Advanced personalization and recommendations.
- Partner APIs for verified data sources.
