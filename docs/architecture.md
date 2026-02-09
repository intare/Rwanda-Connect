# Rwanda Connect Flutter Architecture

## How to Use This Doc
- Use this to guide Flutter folder structure and layer responsibilities.
- Keep feature modules aligned with `INFORMATION_ARCHITECTURE.md`.
- Verify state, routing, and caching choices against `STATE_MANAGEMENT.md`.

This document describes the Flutter architecture for Rwanda Connect, the file structure, and how layers and features map to the app navigation defined in `INFORMATION_ARCHITECTURE.md`.

## Project Structure

```
lib/
  main.dart                        # App entry point
  src/
    core/                          # Cross-cutting utilities
      base/                        # Base classes and interfaces
      di/                          # Dependency injection setup
      extensions/                  # Extension methods
      logger/                      # Logging configuration
      network/                     # API client setup, interceptors
      theme/                       # Theme and design tokens
    data/                          # Data layer
      models/                      # DTOs and API models
      repositories/                # Repository implementations
      services/                    # API and local storage services
      mappers/                     # DTO to domain conversions
    domain/                        # Domain layer
      entities/                    # Core business entities
      repositories/                # Repository interfaces
      use_cases/                   # Business logic use cases
    presentation/                  # Presentation layer
      core/                        # Reusable widgets and UI helpers
      features/                    # Feature modules
        home/
        opportunities/
        events/
        community/
        profile/
        auth/
```

## Feature Modules (Aligned to IA)
- Home: news list, featured opportunities, quick actions.
- Opportunities: list, filters, detail, apply CTA.
- Events: list, filters, detail, RSVP.
- Community: discussions list, create post.
- Profile: basic profile, interests, subscription status.
- Auth: login, register, onboarding.

## Layer Responsibilities

### Core Layer
- Base: shared interfaces and utilities.
- DI: Riverpod provider registration.
- Extensions: app-wide helpers.
- Logger: central logging and error reporting.
- Network: HTTP client, interceptors, auth headers.
- Theme: colors, typography, spacing (from `DESIGN_SPEC.md`).

### Data Layer
- Models: API request/response structures.
- Services: API clients and local storage.
- Repositories: implementation of domain repository interfaces.
- Mappers: DTO to domain conversions.

### Domain Layer
- Entities: core business objects.
- Repositories: interfaces used by use cases.
- Use cases: application logic and orchestration.

### Presentation Layer
- Core: shared widgets, empty states, loading, error widgets.
- Features: screens, widgets, and view models per module.

## State Management
- Riverpod for DI and state.
- Notifiers for state transitions.
- Immutable state models per feature.
- Route guards based on auth and subscription state.

## Environment and Config
- Support dev, staging, and prod.
- Base URLs and keys loaded via environment config.
- Secure storage for tokens and refresh data.

## Error Handling and Caching
- Central error model for API and validation errors.
- Offline-friendly cache for news and opportunities lists.
- Retry and exponential backoff for network failures.

## Routing
- Use `go_router` with nested routes.
- Deep linking for news and opportunity details.
- Route guards for authenticated-only screens.

## Testing Strategy
- Unit tests for use cases and repositories.
- Widget tests for core screens and flows.
- Integration tests for auth, opportunity apply, RSVP.

## CI Expectations
- Lint and format on every PR.
- Unit and widget tests required to pass.
- Build artifacts for release candidates.
