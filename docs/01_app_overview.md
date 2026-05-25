# Gyan Jyoti – App Overview

## 1. Purpose

**Gyan Jyoti** is a mobile learning application designed for **playschool and pre-primary children (ages 2–5)**. It provides a safe, gamified, and colourful digital environment where kids can learn language (English), mathematics, science, and arts & crafts through interactive lessons, quizzes, stories, events, and creative activities.

---

## 2. Target Audience

| Persona | Details |
|---|---|
| **Primary user** | Children aged 2–5 years (playschool / pre-KG / KG) |
| **Secondary user** | Parents and teachers who monitor progress |
| **Use context** | Guided by parent/teacher or semi-independent play |

---

## 3. Core Value Propositions

- **Fun-first learning** – Every lesson is presented as a game or story with animations.
- **Curriculum-aligned** – Content maps to standard playschool syllabi (English, Math, Science, Arts).
- **Progress tracking** – Star badges, completion stats, and a dedicated progress dashboard.
- **Creative expression** – Drawing canvas, coloring pages, scene-building, and origami-style crafts.
- **Safe environment** – No ads, no external links; designed for tiny hands.

---

## 4. High-Level Feature Set

| # | Feature Area | Description |
|---|---|---|
| 1 | **Auth** | Login / Signup with parent/guardian account |
| 2 | **Dashboard (Home)** | Quick access cards, announcements, upcoming events |
| 3 | **Profile** | Child avatar, badges earned, learning stats |
| 4 | **Learn – English** | Alphabets, Simple Words, Colors, Listen & Repeat |
| 5 | **Learn – Math** | Numbers, Counting, Shapes, Addition |
| 6 | **Learn – Science** | Living/Non-Living, Animals, Plants, Human Body, Water & Air |
| 7 | **Learn – Art & Craft** | Creative Drawing, Color & Create, Make a Scene, Fold & Create |
| 8 | **Coloring** | Interactive coloring book (Tree, Animal, Home, Balloon) |
| 9 | **Quiz** | Chapter-based quizzes with score feedback |
| 10 | **Stories** | Illustrated short stories with audio |
| 11 | **Events** | Upcoming and past school events listing |
| 12 | **Games** | Fun mini-games (Match Blocks, Count Blocks) |
| 13 | **Progress** | Stats chart: lessons completed, badges, day streak, top marks |

---

## 5. Platforms

- **Mobile-first** – Android & iOS (Flutter)
- **Screen sizes** – Primarily phones; tablet support desirable for art/coloring features

---

## 6. Tech Stack (Planned)

| Layer | Technology |
|---|---|
| UI Framework | Flutter (Dart) |
| State Management | Riverpod (providers) |
| Navigation | `go_router` via `app_router.dart` |
| Local Storage | Shared Preferences / Hive |
| Networking | Dio-based `ApiClient` |
| Analytics | Pluggable `AnalyticsService` |
| Notifications | `NotificationService` (FCM) |
| DI | `dependency_injection.dart` (get_it / riverpod) |

---

## 7. Design Language

| Token | Value |
|---|---|
| Primary accent | Bright yellow-green (`#C8E000` approx) |
| Background | Off-white / warm white |
| Cards | White with rounded corners (16–24 dp radius) |
| Typography | Rounded, bold, friendly (child-safe) |
| Illustrations | 3-D cartoon-style characters & objects |
| Interaction | Tap → anim feedback; Star badge reward on chapter completion |
