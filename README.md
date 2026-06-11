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
| Database | Supabase (PostgreSQL + pgvector) |
| Data Fetching | TanStack React Query v5 |
| AI | (coming soon) |

## Getting Started

```bash
npm install
npm run dev
```

Copy `.env.local.example` to `.env.local` and fill in Supabase credentials:

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

Open [http://localhost:3000](http://localhost:3000).

## Project Structure

```
src/
├── app/
│   ├── layout.tsx                    # Root layout with font + providers
│   ├── page.tsx                      # Landing page
│   ├── globals.css
│   └── dashboard/
│       ├── layout.tsx                # Dashboard shell
│       ├── page.tsx                  # Dashboard view
│       └── _components/
│           └── balance-cards.tsx     # Income / expense / savings cards
├── components/
│   ├── layout/
│   │   └── app-sidebar.tsx           # Collapsible sidebar with nav
│   └── ui/                           # shadcn/ui primitives
├── config/
│   └── environment.ts                # Typed env vars
├── features/
│   └── action.ts                     # Server actions (balance summary)
├── hooks/
│   └── use-mobile.ts
├── lib/
│   ├── supabase/
│   │   ├── client.ts                 # Browser Supabase client
│   │   ├── server.ts                 # Server Supabase client (SSR)
│   │   └── proxy.ts                  # Middleware proxy helper
│   └── utils.ts                      # cn(), convertToIDR()
├── providers/
│   └── query-client.tsx              # TanStack Query provider
└── proxy.ts                          # Edge proxy entry
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
- [x] Supabase integration (client + server + SSR)
- [x] Balance summary cards (savings, income, expenses)
- [ ] Transaction tracking
- [ ] Budget management
- [ ] AI-powered spending insights
- [ ] Charts & analytics dashboard
- [ ] Accounts & categories management
