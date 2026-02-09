# Requirements

## Goals
- Deliver a mobile-first Flutter app for Rwanda Connect.
- Provide trusted discovery for opportunities, events, and community content.
- Support a basic subscription trial and one gated action in MVP.

## Non-Goals
- Real money transactions for property purchase.
- Full social network or real-time chat in MVP.
- Offline-first for all content in MVP.

## MVP Scope (Must)
- Email/password auth with login/logout and session persistence.
- Basic profile fields: name, email, location, interests.
- Onboarding to capture interests and location with skip option.
- Home feed with curated news list and detail or outbound link.
- Opportunities list with filters, detail view, and apply link.
- Community discussion list with text-only post creation.
- Events list with search and filters, RSVP intent.
- Basic trial/free tier state stored on user profile.
- One gated action (example: apply to opportunity).

## Phase 2 (Should)
- CMS-backed news and playbook content.
- Mentorship and groups with moderation.
- Event creation by organizers with approval workflow.
- Property listings with verification and contact flow.
- Notifications and preferences.

## Phase 3 (Could)
- Multi-language support.
- Personalization and recommendations.
- Partner API integrations for verified data sources.

## Acceptance Criteria (MVP)
- Users can register, log in, and remain logged in after app restart.
- Users can edit their profile and see updated values on refresh.
- Onboarding collects interests and location or is skipped and later resumed.
- Opportunities display list and detail; apply action opens external link.
- Events list supports search and filter; RSVP intent is recorded.
- Community supports creating and viewing text posts.
- Trial state is persisted and gating is enforced for the chosen action.

## Screen Acceptance Criteria (MVP)

### Auth: Login
- Shows email and password fields with validation errors.
- Successful login routes to Home.
- Failed login shows inline error and remains on screen.

### Auth: Register
- Requires name, email, and password.
- Creates a new account and routes to Onboarding.
- Duplicate email shows validation error.

### Onboarding
- Captures interests (at least one) and location.
- Skip option sets status to "incomplete" and routes to Home.
- Completion stores data and routes to Home.

### Home
- Loads news list within 3 seconds on mid-tier device.
- News tap opens detail or external link.
- Error state shows retry option.

### Opportunities List
- List loads with search and filters applied.
- Empty state appears when no results.
- Tapping item opens detail screen.

### Opportunity Detail
- Shows title, company, location, deadline, and apply CTA.
- Apply CTA opens external URL.
- If gated, shows paywall prompt.

### Events List
- List supports search and filters by location/type.
- Empty state appears when no results.
- Tapping item opens detail screen.

### Event Detail
- Shows date, time, location, organizer, and RSVP intent.
- RSVP records intent and shows confirmation.

### Community List
- Displays newest posts first.
- Empty state invites first post creation.

### Create Post
- Text-only input with validation (min 1 char, max 500).
- Successful submit returns to list with new post visible.

### Profile
- Displays editable name, email, location, interests.
- Save persists changes and shows success feedback.
