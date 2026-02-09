# Design Spec

## Visual Direction
- Clean, high-contrast light theme with black accents.
- Minimal gradients, strong typography, and clear hierarchy.

## Typography
- Primary font: "Sora" (fallback: "Poppins", "Roboto").
- Base size: 16.
- Scale: 12, 14, 16, 18, 20, 24, 32.

## Color Tokens
- Primary: #0B0B0B
- Primary Text: #111111
- Secondary Text: #5A5A5A
- Background: #F7F7F7
- Surface: #FFFFFF
- Border: #E0E0E0
- Success: #14804A
- Warning: #B54708
- Danger: #B42318
- Accent: #1D4ED8

## Spacing and Radius
- Spacing scale: 4, 8, 12, 16, 20, 24, 32.
- Radius: 8 for cards, 12 for modals, 999 for pills.

## Core Components
- App bar with search and notification icon.
- Card (news, opportunity, event).
- Filter chips and dropdowns.
- Primary button (filled), secondary button (outline).
- Input fields with error state.
- Empty state with icon and CTA.

## States
- Loading: skeletons for lists and cards.
- Error: inline error on fields, toast for global errors.
- Disabled: 40 percent opacity and no shadow.

## Accessibility
- Minimum contrast ratio 4.5:1.
- Touch target size 44x44.
- Support system font scaling.
