# State Management

## Approach
- Use Riverpod for state and dependency injection.
- Separate data, domain, and UI layers.

## Structure
- data: API clients, DTOs, local storage.
- domain: repositories, models, use cases.
- ui: screens, widgets, providers.

## Caching
- Use local storage for session and profile.
- Cache news and opportunities lists with TTL.

## Error Handling
- Central error model for network and validation errors.
- UI displays inline errors and global toasts.

## Navigation
- Use Navigator 2.0 or go_router for deep links.
- Guard routes based on auth state.
