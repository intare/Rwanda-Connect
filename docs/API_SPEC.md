# API Spec (Draft)

## Headers
- Authorization: Bearer {token}
- Content-Type: application/json

## Pagination
- page: integer (default 1)
- limit: integer (default 20, max 100)
- sort: string (example: "publishDate:desc")
  - format: "{field}:{asc|desc}"

### Pagination Response Metadata
```
"meta": {
  "page": 1,
  "limit": 20,
  "total": 245,
  "hasNext": true,
  "hasPrev": false
}
```

## Filtering
- search: string (full-text search)
- type: string (entity-specific type)
- category: string (entity-specific category)
- location: string (city, country)
- dateFrom: ISO 8601
- dateTo: ISO 8601

## Auth
- POST /auth/register
- POST /auth/login
- POST /auth/logout

### POST /auth/register
Headers:
- Content-Type: application/json
Request:
```
{
  "name": "Jean Claude",
  "email": "jean@example.com",
  "password": "Password123!"
}
```
Response:
```
{
  "data": {
    "token": "jwt-token",
    "user": {
      "id": "user_123",
      "name": "Jean Claude",
      "email": "jean@example.com"
    }
  },
  "error": null
}
```

### POST /auth/login
Headers:
- Content-Type: application/json
Request:
```
{
  "email": "jean@example.com",
  "password": "Password123!"
}
```
Response:
```
{
  "data": {
    "token": "jwt-token",
    "user": {
      "id": "user_123",
      "name": "Jean Claude",
      "email": "jean@example.com"
    }
  },
  "error": null
}
```

### POST /auth/logout
Headers:
- Authorization: Bearer {token}
Response:
```
{
  "data": {
    "success": true
  },
  "error": null
}
```

## Users
- GET /users/me
- PATCH /users/me

### GET /users/me
Headers:
- Authorization: Bearer {token}
Response:
```
{
  "data": {
    "id": "user_123",
    "name": "Jean Claude",
    "email": "jean@example.com",
    "location": "Toronto, Canada",
    "interests": ["Technology", "Investment"],
    "subscription": {
      "plan": "trial",
      "status": "active"
    }
  },
  "error": null
}
```

### PATCH /users/me
Headers:
- Authorization: Bearer {token}
- Content-Type: application/json
Request:
```
{
  "name": "Jean Claude",
  "location": "Toronto, Canada",
  "interests": ["Technology", "Investment"]
}
```
Response:
```
{
  "data": {
    "id": "user_123",
    "name": "Jean Claude",
    "location": "Toronto, Canada",
    "interests": ["Technology", "Investment"]
  },
  "error": null
}
```

## News
- GET /news
- GET /news/{id}

### GET /news
Query:
- page, limit, sort, search, category
Filter schema:
- search: string (title, summary, tags)
- category: string (Economy, Investment, Events, Business, Policy)
Default ordering:
- publishDate:desc
Sort examples:
- publishDate:desc
- title:asc
Response:
```
{
  "data": [
    {
      "id": "news_001",
      "title": "Diaspora Remittances Hit Record",
      "source": "The New Times",
      "category": "Economy",
      "summary": "Short summary text",
      "publishDate": "2025-08-30T00:00:00Z",
      "url": "https://example.com/news/001"
    }
  ],
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 245,
    "hasNext": true,
    "hasPrev": false
  },
  "error": null
}
```

### GET /news/{id}
Query:
- None
Response:
```
{
  "data": {
    "id": "news_001",
    "title": "Diaspora Remittances Hit Record",
    "source": "The New Times",
    "category": "Economy",
    "summary": "Short summary text",
    "publishDate": "2025-08-30T00:00:00Z",
    "url": "https://example.com/news/001"
  },
  "error": null
}
```

## Opportunities
- GET /opportunities
- GET /opportunities/{id}

### GET /opportunities
Query:
- page, limit, sort, search, type, location
Filter schema:
- search: string (title, company, location)
- type: string (job, investment, scholarship, tender)
- location: string (city, country)
Default ordering:
- deadline:asc
Sort examples:
- datePosted:desc
- salary:desc
- title:asc
Response:
```
{
  "data": [
    {
      "id": "opp_001",
      "type": "job",
      "title": "Senior Software Engineer",
      "company": "PayRwanda Ltd",
      "location": "Kigali, Rwanda",
      "salary": 55000,
      "deadline": "2025-09-15T00:00:00Z",
      "verified": true
    }
  ],
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 58,
    "hasNext": true,
    "hasPrev": false
  },
  "error": null
}
```

### GET /opportunities/{id}
Query:
- None
Response:
```
{
  "data": {
    "id": "opp_001",
    "type": "job",
    "title": "Senior Software Engineer",
    "company": "PayRwanda Ltd",
    "location": "Kigali, Rwanda",
    "salary": 55000,
    "deadline": "2025-09-15T00:00:00Z",
    "verified": true,
    "applyUrl": "https://example.com/apply/opp_001"
  },
  "error": null
}
```

## Events
- GET /events
- GET /events/{id}
- POST /events/{id}/rsvp

### GET /events
Query:
- page, limit, sort, search, type, location, dateFrom, dateTo
Filter schema:
- search: string (title, description, location)
- type: string (networking, seminar, workshop, conference)
- location: string (city, country)
- dateFrom: ISO 8601
- dateTo: ISO 8601
Default ordering:
- date:asc
Sort examples:
- date:asc
- rsvpCount:desc
Response:
```
{
  "data": [
    {
      "id": "event_001",
      "title": "Rwanda Connect Toronto Networking Night",
      "location": "Toronto, Canada",
      "date": "2025-09-15T18:00:00Z",
      "type": "networking",
      "organizer": "Rwanda Connect",
      "rsvpCount": 67
    }
  ],
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 12,
    "hasNext": false,
    "hasPrev": false
  },
  "error": null
}
```

### GET /events/{id}
Query:
- None
Response:
```
{
  "data": {
    "id": "event_001",
    "title": "Rwanda Connect Toronto Networking Night",
    "location": "Toronto, Canada",
    "date": "2025-09-15T18:00:00Z",
    "type": "networking",
    "organizer": "Rwanda Connect",
    "rsvpCount": 67,
    "description": "Short event description"
  },
  "error": null
}
```

### POST /events/{id}/rsvp
Headers:
- Authorization: Bearer {token}
- Content-Type: application/json
Request:
```
{
  "status": "going"
}
```
Response:
```
{
  "data": {
    "eventId": "event_001",
    "status": "going"
  },
  "error": null
}
```

## Community
- GET /community/posts
- POST /community/posts

### GET /community/posts
Query:
- page, limit, sort, search
Filter schema:
- search: string (content, author name)
Default ordering:
- createdAt:desc
Sort examples:
- createdAt:desc
Response:
```
{
  "data": [
    {
      "id": "post_001",
      "authorId": "user_123",
      "content": "How do I transition into fintech?",
      "createdAt": "2025-08-30T12:00:00Z"
    }
  ],
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 42,
    "hasNext": true,
    "hasPrev": false
  },
  "error": null
}
```

### POST /community/posts
Headers:
- Authorization: Bearer {token}
- Content-Type: application/json
Request:
```
{
  "content": "How do I transition into fintech?"
}
```
Response:
```
{
  "data": {
    "id": "post_001",
    "authorId": "user_123",
    "content": "How do I transition into fintech?",
    "createdAt": "2025-08-30T12:00:00Z"
  },
  "error": null
}
```

## Subscriptions
- GET /subscriptions/me
- POST /subscriptions/activate
- POST /subscriptions/portal
- POST /subscriptions/webhooks

### GET /subscriptions/me
Headers:
- Authorization: Bearer {token}
Response:
```
{
  "data": {
    "plan": "trial",
    "status": "active",
    "startDate": "2025-09-01T00:00:00Z"
  },
  "error": null
}
```

### POST /subscriptions/activate
Headers:
- Authorization: Bearer {token}
- Content-Type: application/json
Request:
```
{
  "plan": "trial"
}
```
Response:
```
{
  "data": {
    "plan": "trial",
    "status": "active",
    "startDate": "2025-09-01T00:00:00Z"
  },
  "error": null
}
```

### POST /subscriptions/portal
Headers:
- Authorization: Bearer {token}
Response:
```
{
  "data": {
    "url": "https://billing.example.com/portal/session_123"
  },
  "error": null
}
```

### POST /subscriptions/webhooks
Headers:
- Content-Type: application/json
Request:
```
{
  "event": "subscription.renewed",
  "provider": "app_store",
  "payload": {}
}
```
Response:
```
{
  "data": {
    "received": true
  },
  "error": null
}
```

## Common Response (Example)
```
{
  "data": {},
  "error": null
}
```

## Error Codes
- auth_invalid_credentials
- auth_email_in_use
- auth_unauthorized
- validation_error
- not_found
- rate_limited
- server_error

## Common Error (Example)
```
{
  "data": null,
  "error": {
    "code": "validation_error",
    "message": "Invalid request"
  }
}
```
