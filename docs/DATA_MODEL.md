# Data Model

## User
| Field | Type | Notes |
| --- | --- | --- |
| id | string | UUID |
| name | string | Required |
| email | string | Required, unique |
| location | string | City, country |
| interests | array | List of strings |
| role | string | user, admin, organizer |
| subscription | object | Plan and status |

## Subscription
| Field | Type | Notes |
| --- | --- | --- |
| plan | string | free, trial, monthly, yearly |
| status | string | active, expired |
| startDate | string | ISO 8601 |
| endDate | string | ISO 8601 |

## Opportunity
| Field | Type | Notes |
| --- | --- | --- |
| id | string | UUID |
| type | string | job, investment, scholarship, tender |
| title | string | Required |
| company | string | Optional |
| location | string | Required |
| salary | number | Optional |
| deadline | string | ISO 8601 |
| verified | boolean | Required |
| applyUrl | string | External link |

## NewsArticle
| Field | Type | Notes |
| --- | --- | --- |
| id | string | UUID |
| title | string | Required |
| source | string | Required |
| category | string | Required |
| summary | string | Required |
| publishDate | string | ISO 8601 |
| url | string | Optional |

## Event
| Field | Type | Notes |
| --- | --- | --- |
| id | string | UUID |
| title | string | Required |
| location | string | Required |
| date | string | ISO 8601 |
| type | string | meetup, workshop, conference |
| organizer | string | Required |
| rsvpCount | number | Computed |

## CommunityPost
| Field | Type | Notes |
| --- | --- | --- |
| id | string | UUID |
| authorId | string | User id |
| content | string | Text-only in MVP |
| createdAt | string | ISO 8601 |

## RSVP
| Field | Type | Notes |
| --- | --- | --- |
| id | string | UUID |
| eventId | string | Event id |
| userId | string | User id |
| status | string | going, interested |
