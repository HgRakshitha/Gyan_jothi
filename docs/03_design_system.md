# UI / UX Design System

> Reference for all visual tokens, component patterns, and interaction guidelines extracted from the UI screenshots.

---

## 1. Color Palette

| Token Name | Hex (approx) | Usage |
|---|---|---|
| `colorPrimary` | `#C9E500` | App bar background, active chips, CTA buttons |
| `colorBackground` | `#F5F5F0` | Page scaffold background |
| `colorSurface` | `#FFFFFF` | Cards, bottom sheets, input fields |
| `colorTextPrimary` | `#1A1A1A` | Headlines, body text |
| `colorTextSecondary` | `#6B6B6B` | Subtitles, captions, labels |
| `colorAccentPink` | `#FFB5C8` | English subject card |
| `colorAccentPurple` | `#D5C5F5` | Color & Create card |
| `colorAccentBlue` | `#B5D8FF` | Math / general info cards |
| `colorAccentOrange` | `#FFD9A0` | Events / Art cards |
| `colorAccentGreen` | `#B8F0C8` | Science / nature cards |
| `colorStarGold` | `#FFD700` | Badge stars, reward icons |
| `colorShadow` | `rgba(0,0,0,0.08)` | Card elevation shadow |

---

## 2. Typography

| Style Name | Weight | Size (sp) | Usage |
|---|---|---|---|
| `headlineLarge` | ExtraBold | 22 | Page/Section title (e.g., "English", "Math") |
| `headlineMedium` | Bold | 18 | Card headings, chapter names |
| `titleMedium` | SemiBold | 16 | Lesson titles, list item primary text |
| `bodyMedium` | Regular | 14 | Lesson descriptions, body copy |
| `bodySmall` | Regular | 12 | Captions, metadata (type label, star count) |
| `labelSmall` | Medium | 10 | Tags ("Beginner", subject chip) |

**Font Family:** Rounded/friendly sans-serif (e.g., Nunito, Poppins, or equivalent)

---

## 3. Spacing & Sizing

| Token | Value | Usage |
|---|---|---|
| `paddingPage` | 16 dp | Left/right page margin |
| `paddingSection` | 12 dp | Between sections |
| `paddingCard` | 12–16 dp | Inner card padding |
| `gapItems` | 8–12 dp | Gap between list items |
| `radiusCard` | 16 dp | Standard card corner radius |
| `radiusCardLarge` | 24 dp | Hero card / bottom-sheet radius |
| `radiusButton` | 32 dp | Pill-shaped buttons |
| `radiusChip` | 16 dp | Filter chips (Upcoming / Past Events) |
| `appBarHeight` | 56 dp | Standard app bar |
| `bottomNavHeight` | 64 dp | Bottom navigation bar |

---

## 4. Component Patterns

### 4.1 App Bar (`CustomAppBar`)
- **Style A (Yellow-Green):** Used on subject/chapter pages. Background = `colorPrimary`, back arrow left, title centred, notification bell right.
- **Style B (Transparent/White):** Used on Home tab. Shows user avatar + name top-left, coin badge top-right.

### 4.2 Bottom Navigation Bar (`BottomNavBar`)
- 2 tabs: **Home** (house icon) · **Profile** (face icon)
- Active tab highlighted with yellow-green pill indicator.

### 4.3 Search Bar (`SearchBar`)
- Full-width, rounded pill shape.
- Leading search icon; trailing mic/filter icon.
- Background: light grey (#EEEEEE).

### 4.4 Quick Access Card (`QuickAccessCard`)
- Rounded rectangle, coloured background per subject.
- Icon (3-D illustration) top; label text below.
- Grid layout: 2×2 on Home screen.

### 4.5 Chapter Card / List Item (`ChapterCard`)
- Full-width row inside a white card container.
- Left: subject illustration thumbnail (rounded).
- Centre: chapter title + short description.
- Right: difficulty badge (star count) + chevron arrow.
- Bottom divider between items.

### 4.6 Lesson Row (`LessonRow` inside chapter page)
- Similar to ChapterCard but smaller.
- Type badge: `Book` 📖 · `Video` 🎵 · `Activity` 🎮.
- Star rating dots (1–3 stars) showing difficulty.

### 4.7 Quiz Card (`QuizCard`)
- Coloured card with category chip (e.g., "English · Beginner").
- Illustration right side.
- Star rating bottom-left.

### 4.8 Story Card (`StoryCard`)
- Horizontal row: illustration thumbnail left → title + short description centre → read button right.

### 4.9 Event Card (`EventCard`)
- Full-width row with event illustration right, date + title + status chip left.
- Status chip: "Upcoming" (green) / "Past" (grey).

### 4.10 Badge Card (`BadgeCard`)
- Square card with 3-D trophy/star icon, badge name below.

### 4.11 Drawing Step Card
- Numbered step label top.
- Large dotted/outlined drawing guide centre.
- **Done** button at bottom.

### 4.12 Coloring Canvas
- White background canvas with black outline illustration.
- Color palette strip at top (6–8 swatches).
- Toolbar bottom: Zoom+, Zoom−, Undo, Download.

### 4.13 Scene Builder
- Full-screen illustrative background image.
- Scrollable horizontal sticker strip at top.
- **Done** button bottom.

### 4.14 Progress Stats Row
- Horizontal row of 4 stat blocks: icon + number + label.
- Seen on Profile page: Lessons Completed · Quizzes · Badges · Day Streak.

### 4.15 Star Badge Reward Banner
- Displayed at top of chapter pages.
- Text: "Complete the chapter and earn a ★ star badge!"
- Shows 1, 2, or 3 gold star icons depending on difficulty.

---

## 5. Icon & Illustration Style

- **3-D cartoon illustrations** for all subject cards, story thumbnails, event images.
- **2-D line SVG icons** for toolbar actions (zoom, undo, back arrow, bell).
- **Emoji-style icons** for lesson-type badges (📖 📹 🎮).
- Illustrations provided as PNG/WebP assets in `assets/images/`.

---

## 6. Animation Guidelines

| Trigger | Animation |
|---|---|
| Splash screen | Logo fade-in + scale-up |
| Page transition | Slide from right (Go Router) |
| Chapter completion | Star burst + confetti |
| Lesson tap | Scale bounce on card |
| Coloring fill | Flood-fill with smooth color spread animation |
| Scene sticker drop | Drop + slight bounce |
| Quiz correct answer | Green flash + ✓ icon |
| Quiz wrong answer | Red shake |

---

## 7. Accessibility Notes

- All interactive elements must have semantic labels (for screen readers).
- Minimum touch target: 44×44 dp.
- Text contrast ratio ≥ 4.5:1 on all backgrounds.
- Large tap areas on coloring palette swatches (min 36×36 dp).
