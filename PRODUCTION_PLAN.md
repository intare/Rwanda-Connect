# Rwanda Connect - Production Readiness Plan

## Immediate Fixes Required

### 1. Offline Banner Bug (HIGH PRIORITY)
**Issue:** The offline banner shows even when online because `ConnectivityStatus` starts as `unknown`, and `isOnline` returns `false` for `unknown`.

**File:** `lib/src/core/network/connectivity_service.dart`

**Fix:** Change the logic to treat `unknown` as online until confirmed offline.

---

### 2. Image Fields Missing (HIGH PRIORITY)
**Issue:** Some entities lack image support.

| Entity | Has Image Field | Status |
|--------|----------------|--------|
| News | Yes (`imageUrl`) | Working |
| Event | Yes (`imageUrl`) | Needs mapper check |
| Opportunity | No | **Needs to add** |
| User | No (profile photo) | **Needs to add** |
| Post | No | **Needs to add** |

---

## Production Readiness Improvements

### A. Authentication & Security
- [ ] Token refresh mechanism (auto-refresh before expiry)
- [ ] Biometric authentication option
- [ ] Session timeout handling
- [ ] Secure API key management (remove hardcoded keys)

### B. Error Handling & UX
- [ ] Global error boundary
- [ ] Retry mechanisms for failed API calls
- [ ] Better loading states (skeleton loaders)
- [ ] Pull-to-refresh on all list screens
- [ ] Empty state designs

### C. Performance
- [ ] Image caching with `cached_network_image`
- [ ] Lazy loading for lists
- [ ] Pagination optimization
- [ ] Memory management for large lists
- [ ] App size optimization

### D. Offline Support
- [ ] Fix connectivity detection (current bug)
- [ ] Queue offline actions (likes, comments, RSVPs)
- [ ] Sync when back online
- [ ] Show stale data indicators

### E. Data & API
- [ ] Add image fields to all entities
- [ ] Rich text rendering for content
- [ ] Date/time localization
- [ ] Currency formatting for salary fields

### F. Testing
- [ ] Unit tests for services
- [ ] Widget tests for screens
- [ ] Integration tests for auth flow
- [ ] Mock API responses for testing

### G. App Polish
- [ ] App icon and splash screen (done)
- [ ] Push notifications setup
- [ ] Deep linking configuration
- [ ] Share functionality
- [ ] Rate app prompt

### H. Analytics & Monitoring
- [ ] Firebase Analytics events
- [ ] Crashlytics integration
- [ ] Performance monitoring
- [ ] User behavior tracking

### I. Build & Release
- [ ] ProGuard/R8 rules for release
- [ ] Code signing setup
- [ ] Play Store listing
- [ ] App Store listing
- [ ] CI/CD pipeline

---

## Implementation Order

### Phase 1: Critical Fixes (Today)
1. Fix offline banner bug
2. Add image fields to Opportunity, User, Post entities
3. Update mappers for image URLs

### Phase 2: Core Improvements (This Week)
4. Add `cached_network_image` for image caching
5. Implement pull-to-refresh
6. Add skeleton loading states
7. Token refresh mechanism

### Phase 3: Polish (Next Week)
8. Push notifications
9. Share functionality
10. Analytics events
11. Testing

### Phase 4: Release Prep
12. Performance optimization
13. Build configuration
14. Store listings
