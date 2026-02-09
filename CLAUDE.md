# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Rwanda Connect is a Flutter mobile app connecting the Rwandan diaspora to opportunities, community, events, and property listings. The project is currently in the **documentation/planning phase** - comprehensive specs exist in `/docs/` but Flutter implementation has not yet begun.

## Project Status

- **Current state**: Pre-development (specs complete, implementation ready to begin)
- **Tech stack**: Flutter, Riverpod (state management), go_router (navigation)
- **Target platforms**: iOS, Android, Web

## Build Commands

Once implementation begins:

```bash
flutter pub get                    # Install dependencies
flutter pub run build_runner build # Generate code (freezed, json_serializable)
flutter run                        # Run in development
flutter test                       # Run all tests
flutter test --coverage            # Generate coverage report
flutter build apk                  # Build Android release
flutter build ios                  # Build iOS release
dart format lib/                   # Format code
dart analyze lib/                  # Run static analysis
```

## Architecture

The project follows **Clean Architecture** with three layers:

```
lib/src/
├── core/           # Cross-cutting: DI (Riverpod), network, theme, extensions
├── data/           # API clients, DTOs, repository implementations, mappers
├── domain/         # Entities, repository interfaces, use cases
└── presentation/   # UI layer organized by feature
    └── features/
        ├── auth/          # Login, register, onboarding
        ├── home/          # News feed, featured opportunities
        ├── opportunities/ # Job/investment listings
        ├── events/        # Event discovery, RSVP
        ├── community/     # Discussions, posts
        └── profile/       # User profile, subscription status
```

**Key patterns**:
- Riverpod for dependency injection and state management
- go_router for navigation with deep linking and route guards
- Immutable models using freezed
- Bearer token authentication stored in secure storage

## Key Documentation

Read these docs in `/docs/` for context:

| File | Purpose |
|------|---------|
| `architecture.md` | Folder structure and layer responsibilities |
| `PRD.md` | Product requirements and phased delivery |
| `API_SPEC.md` | REST API endpoints and request/response formats |
| `ENTITLEMENTS.md` | Subscription plans and feature gating |
| `DESIGN_SPEC.md` | Colors, typography, spacing, components |
| `INFORMATION_ARCHITECTURE.md` | Navigation structure (5 bottom tabs) |

## MVP Scope

The MVP includes:
- Email/password authentication with session persistence
- User profile with interests and location
- Onboarding flow (skippable)
- Home dashboard with news feed
- Opportunities marketplace (list, filter, detail, external apply link)
- Events discovery (list, filter, RSVP)
- Community discussions (text-only posts)
- Subscription/trial with gating on "Apply to opportunities"

**Not in MVP**: Properties, Career Playbook, Notifications, Admin portal, Mentorship matching

## API Response Format

All API responses follow this structure:
```json
{
  "data": { ... },
  "error": null
}
```

Pagination uses `page`, `limit`, `sort` query params with response `meta` containing `hasNext`/`hasPrev`.

## Subscription Model

| Plan | Key Entitlements |
|------|------------------|
| Free | Browse only, no apply/bookmark |
| Trial (30 days) | Apply, bookmark, mentorship |
| Monthly/Yearly | All features, unlimited |

Primary paywall trigger: "Apply to opportunities"

## Implementation Order

When starting development:
1. Project setup (pubspec.yaml, folder structure, Riverpod config)
2. Auth module (login/register/onboarding)
3. Core infrastructure (theme, routing, error handling)
4. Home feed (news API integration)
5. Opportunities (list, filter, detail)
6. Events and Community
7. Profile and subscription gating
