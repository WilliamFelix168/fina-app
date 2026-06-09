# Fina — AI-Powered Personal Finance App

A personal finance application built with Next.js 16 and AI capabilities to help you track, understand, and manage your finances.

## Tech Stack

| Layer | Tech |
|-------|------|
| Framework | Next.js 16.2 (App Router) |
| Language | TypeScript 5 |
| Styling | Tailwind CSS v4 |
| UI Components | shadcn/ui + Radix UI |
| Icons | Lucide React |
| Fonts | Outfit, Geist (via `next/font`) |
| AI | (coming soon) |

## Getting Started

```bash
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000).

## Project Structure

```
src/
├── app/
│   ├── layout.tsx          # Root layout with font + tooltip provider
│   ├── page.tsx            # Landing page
│   ├── globals.css
│   └── dashboard/
│       ├── layout.tsx      # Dashboard shell
│       └── page.tsx        # Dashboard view
├── components/
│   ├── layout/
│   │   └── app-sidebar.tsx  # Collapsible sidebar with nav (Dashboard, Transaction)
│   └── ui/                  # shadcn/ui primitives
│       ├── button.tsx
│       ├── card.tsx
│       ├── input.tsx
│       ├── separator.tsx
│       ├── sheet.tsx
│       ├── sidebar.tsx
│       ├── skeleton.tsx
│       └── tooltip.tsx
├── hooks/
│   └── use-mobile.ts
└── lib/
    └── utils.ts            # cn() helper
```

## Scripts

```bash
npm run dev      # Start dev server
npm run build    # Production build
npm run start    # Start production server
npm run lint     # ESLint
```

## Roadmap

- [x] Dashboard layout with collapsible sidebar
- [ ] Transaction tracking
- [ ] Budget management
- [ ] AI-powered spending insights
- [ ] Charts & analytics dashboard
- [ ] Accounts & categories management
