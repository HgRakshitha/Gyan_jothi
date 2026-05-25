# Folder Structure & File Purpose Guide

> This document explains the purpose of every folder and file in the `lib/` architecture, and maps each file to the screens/features it serves.

---

## Root Level

| File | Purpose |
|---|---|
| `main.dart` | App entry point. Runs `runApp()`, sets up Flutter bindings, initialises DI. |
| `app.dart` | Root `MaterialApp` / `ProviderScope`. Wires theme, router, and locale. |

---

## `config/`

### `env/`

| File | Purpose |
|---|---|
| `dev_env.dart` | Development environment constants (base URL, feature flags, debug logging). |
| `prod_env.dart` | Production environment constants (live API base URL, analytics keys). |

### Root config files

| File | Purpose |
|---|---|
| `dependency_injection.dart` | Registers all services, repositories, and providers (get_it / riverpod overrides). |

---

## `core/`

### `constants/`

| File | Purpose |
|---|---|
| `app_colors.dart` | All color tokens (`colorPrimary`, `colorBackground`, subject-specific accent colors). |
| `app_strings.dart` | All static/localised string keys (screen titles, button labels, error messages). |
| `app_assets.dart` | Asset path constants (`Assets.images.banner`, `Assets.sounds.correctAnswer`, etc.). |
| `app_sizes.dart` | Spacing, radius, and sizing tokens (`paddingPage`, `radiusCard`, etc.). |

### `theme/`

| File | Purpose |
|---|---|
| `app_theme.dart` | `ThemeData` builder for light (and optionally dark) theme. Applies colors + typography. |
| `text_styles.dart` | All named `TextStyle` definitions (`headlineLarge`, `bodyMedium`, etc.). |

### `router/`

| File | Purpose |
|---|---|
| `app_router.dart` | All named routes using `go_router`. Defines guards (auth check → redirect to Login). |

**Route names used:**

```
/splash
/login
/signup
/home
/profile
/learn
/learn/english
/learn/english/alphabets
/learn/english/simple-words
/learn/english/colors
/learn/english/listen-report
/learn/math
/learn/math/numbers
/learn/math/counting
/learn/math/shapes
/learn/math/addition
/learn/science
/learn/science/living-nonliving
/learn/science/animals
/learn/science/plants
/learn/science/human-body
/learn/science/water-air
/learn/art-craft
/learn/art-craft/creative-drawing
/learn/art-craft/draw-sun
/learn/art-craft/draw-tree
/learn/art-craft/draw-bicycle
/learn/art-craft/draw-home
/learn/art-craft/color-create
/learn/art-craft/color-tree
/learn/art-craft/color-animal
/learn/art-craft/color-home
/learn/art-craft/color-balloon
/learn/art-craft/make-scene
/learn/art-craft/make-scene/park
/learn/art-craft/make-scene/farm
/learn/art-craft/make-scene/birthday-party
/learn/art-craft/make-scene/classroom
/learn/art-craft/fold-create
/quiz
/quiz/question
/stories
/stories/:id
/events
/games
/games/match-blocks
/games/count-blocks
/progress
```

### `network/`

| File | Purpose |
|---|---|
| `api_client.dart` | Dio instance with interceptors (auth token injection, logging, error handling). |
| `api_endpoints.dart` | All API endpoint path constants (`ApiEndpoints.login`, `ApiEndpoints.stories`, etc.). |

### `error/`

| File | Purpose |
|---|---|
| `failures.dart` | Sealed `Failure` classes: `ServerFailure`, `NetworkFailure`, `CacheFailure`. |
| `exceptions.dart` | Raw exception types thrown by data sources before mapping to Failures. |

### `services/`

| File | Purpose |
|---|---|
| `storage_service.dart` | Abstract interface + implementation for local key-value storage (user token, progress, coloring state). |
| `analytics_service.dart` | Tracks events: lesson_started, lesson_completed, quiz_submitted, badge_earned, etc. |
| `notification_service.dart` | FCM initialisation, local notification scheduling for events/reminders. |

### `utils/`

| File | Purpose |
|---|---|
| `helpers.dart` | General utility functions (date formatting, string truncation, coin formatter). |
| `validators.dart` | Form validators for email, password, required fields. |
| `logger.dart` | Structured logger wrapper (debug/info/warning/error) using `--logger` package or `print` in dev. |

---

## `shared/`

### `widgets/`

| File | Screens It Serves |
|---|---|
| `custom_button.dart` | Auth, lesson "Done" button, quiz options |
| `custom_card.dart` | Base rounded card used by chapter/lesson/quiz/story cards |
| `custom_appbar.dart` | All subject/chapter/feature pages (yellow-green top bar) |
| `search_bar.dart` | Home, Learn hub, Quiz home, Stories list |
| `progress_bar.dart` | Progress page, chapter completion indicator |
| `bottom_nav_bar.dart` | Main tab shell (Home + Profile tabs) |
| `loading_widget.dart` | All async data-loading states |

### `extensions/`

| File | Purpose |
|---|---|
| `context_extension.dart` | `context.theme`, `context.colorScheme`, `context.screenWidth` helpers. |
| `string_extension.dart` | `str.capitalize()`, `str.truncate(n)`, `str.isValidEmail` helpers. |

### `providers/`

| File | Purpose |
|---|---|
| `theme_provider.dart` | Manages light/dark theme toggle (state persisted via storage service). |
| `user_provider.dart` | Holds authenticated user state (child name, class, coins, badges). |

---

## `features/`

### `splash/`
| File | Screen |
|---|---|
| `pages/splash_page.dart` | SCR-SHELL-01 – Animated splash |

### `auth/`
| File | Screen / Purpose |
|---|---|
| `pages/login_page.dart` | SCR-AUTH-01 |
| `pages/signup_page.dart` | SCR-AUTH-02 |
| `widgets/auth_input.dart` | Styled text field with label + validation |
| `providers/auth_provider.dart` | Login/signup state, token storage |

### `dashboard/`
| File | Screen / Purpose |
|---|---|
| `pages/dashboard_page.dart` | SCR-HOME-01 – Home tab |
| `pages/main_tab_page.dart` | SCR-SHELL-02 – Bottom nav shell |
| `widgets/quick_access_card.dart` | Quick access grid item (Learn/Quiz/Events/Stories) |
| `widgets/event_card.dart` | Announcement/event row item on Home |
| `widgets/story_card.dart` | Story preview card on Home |

### `profile/`
| File | Screen / Purpose |
|---|---|
| `pages/profile_page.dart` | SCR-PROF-01 |
| `widgets/stats_card.dart` | Single stat block (Lessons/Quizzes/Badges/Streak) |
| `widgets/badge_card.dart` | Badge display card (Star Learner, Quiz Master, etc.) |

### `learn/english/`
| File | Screen |
|---|---|
| `pages/english_home_page.dart` | SCR-ENG-00 |
| `pages/alphabets_page.dart` | SCR-ENG-01 |
| `pages/simple_words_page.dart` | SCR-ENG-02 |
| `pages/colors_page.dart` | SCR-ENG-03 |
| `pages/listen_report_page.dart` | SCR-ENG-04 |
| `widgets/english_lesson_card.dart` | Lesson row (type badge + star rating + chevron) |

### `learn/math/`
| File | Screen |
|---|---|
| `pages/numbers_page.dart` | SCR-MTH-01 |
| `pages/counting_page.dart` | SCR-MTH-02 |
| `pages/shapes_page.dart` | SCR-MTH-03 |
| `pages/addition_page.dart` | SCR-MTH-04 |
| `widgets/math_lesson_card.dart` | Math-themed lesson row |

> **Note:** Add `math_home_page.dart` to mirror `english_home_page.dart`.

### `learn/science/`
| File | Screen |
|---|---|
| `pages/living_nonliving_page.dart` | SCR-SCI-01 |
| `pages/animals_page.dart` | SCR-SCI-02 |
| `pages/plants_page.dart` | SCR-SCI-03 |
| `pages/human_body_page.dart` | SCR-SCI-04 |
| `pages/water_air_page.dart` | SCR-SCI-05 |
| `widgets/science_card.dart` | Science-themed lesson row |

> **Note:** Add `science_home_page.dart`.

### `learn/art_craft/`
| File | Screen |
|---|---|
| `pages/creative_drawing_page.dart` | SCR-ART-01 – Chapter list |
| `pages/draw_sun_page.dart` | SCR-ART-02 |
| `pages/draw_tree_page.dart` | SCR-ART-03 |
| `pages/draw_bicycle_page.dart` | SCR-ART-04 |
| `pages/draw_home_page.dart` | SCR-ART-05 |
| `widgets/drawing_canvas.dart` | Step viewer + dotted guide canvas |

> **Note:** Add `art_craft_home_page.dart`, `color_create_page.dart`, plus Make a Scene and Fold & Create page files listed in the coloring feature.

### `coloring/`

> **Refactoring note:** Coloring sub-feature lives under `learn/art_craft/` in the UI, but is large enough to keep as a standalone feature folder. Both approaches are acceptable; keep consistent across the team.

| File | Screen |
|---|---|
| `pages/color_tree_page.dart` | SCR-COL-01 |
| `pages/color_animal_page.dart` | SCR-COL-02 |
| `pages/color_home_page.dart` | SCR-COL-03 |
| `pages/color_balloon_page.dart` | SCR-COL-04 |
| `widgets/color_palette.dart` | Swatch strip + flood-fill interaction |

### `quiz/`
| File | Screen |
|---|---|
| `pages/quiz_home_page.dart` | SCR-QZ-00 |
| `pages/quiz_question_page.dart` | SCR-QZ-01 |
| `widgets/quiz_option.dart` | Answer option card (normal / correct / wrong state) |
| `widgets/quiz_card.dart` | Quiz listing card with subject chip + star rating |

### `stories/`
| File | Screen |
|---|---|
| `pages/stories_list_page.dart` | SCR-STR-00 |
| `pages/story_detail_page.dart` | SCR-STR-01 |
| `widgets/story_item.dart` | Story list row (thumbnail + title + teaser) |

### `events/`
| File | Screen |
|---|---|
| `pages/upcoming_events_page.dart` | SCR-EVT-00 |
| `pages/past_events_page.dart` | SCR-EVT-01 |
| `widgets/event_item.dart` | Event list row (image + title + date + chip) |

### `games/`
| File | Screen |
|---|---|
| `pages/fun_games_page.dart` | SCR-GAM-00 |
| `pages/match_blocks_game.dart` | SCR-GAM-01 |
| `pages/count_blocks_game.dart` | SCR-GAM-02 |
| `widgets/game_card.dart` | Game hub listing card |

### `progress/`
| File | Screen |
|---|---|
| `pages/progress_page.dart` | SCR-PRG-00 |
| `widgets/stats_chart.dart` | Bar/radial chart for subject completion |

---

## `assets/`

| Folder | Contents |
|---|---|
| `assets/images/` | 3-D cartoon illustrations (PNG/WebP): subject banners, story thumbnails, event images, coloring outlines, character avatars |
| `assets/icons/` | SVG/PNG icons: nav icons, toolbar icons, badge icons |
| `assets/animations/` | Lottie JSON files: splash animation, star burst, confetti, correct/wrong feedback |
| `assets/sounds/` | MP3/AAC: lesson audio narrations, correct/wrong sounds, background music |
