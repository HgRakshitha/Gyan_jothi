# Screen Inventory & Navigation Map

> Every screen visible across the provided UI screenshots is catalogued here, mapped to its feature folder, and described.

---

## Navigation Structure

```
Splash
 └── Auth
       ├── Login
       └── Signup
             └── Main Tab Shell  (Bottom Nav: Home · Profile)
                   ├── [Home Tab]  Dashboard
                   ├── [Profile Tab]  Profile
                   │
                   ├── Learn Hub
                   │     ├── English Home ──► Alphabets · Simple Words · Colors · Listen & Report
                   │     ├── Math Home    ──► Numbers · Counting · Shapes · Addition
                   │     ├── Science Home ──► Living/Non-Living · Animals · Plants · Human Body · Water & Air
                   │     └── Art & Craft  ──► Creative Drawing · Color & Create · Make a Scene · Fold & Create
                   │
                   ├── Quiz Hub      ──► Quiz Question
                   ├── Stories List  ──► Story Detail
                   ├── Events        ──► Upcoming / Past tabs
                   ├── Games         ──► Match Blocks · Count Blocks
                   └── Progress
```

---

## Screen Catalogue

### Auth

| Screen ID | File | Description |
|---|---|---|
| SCR-AUTH-01 | `login_page.dart` | Email + password login for parent/guardian |
| SCR-AUTH-02 | `signup_page.dart` | Account creation |

---

### Core Shell

| Screen ID | File | Description |
|---|---|---|
| SCR-SHELL-01 | `splash_page.dart` | Animated splash with logo |
| SCR-SHELL-02 | `main_tab_page.dart` | Bottom navigation shell (Home / Profile tabs) |

---

### Dashboard (Home)

| Screen ID | File | Description | Key UI Elements |
|---|---|---|---|
| SCR-HOME-01 | `dashboard_page.dart` | Main home screen | Search bar, Quick Access cards (Learn, Quiz, Events, Stories), hero illustration, Announcements list |

**Quick Access Cards visible:** Learn · Quiz · Events · Stories

**Announcements:** School Holiday Notice · New Quiz Available · Upcoming Event

---

### Profile

| Screen ID | File | Description | Key UI Elements |
|---|---|---|---|
| SCR-PROF-01 | `profile_page.dart` | Child profile | Avatar, Name, School, Coin count, My Badges section, Learning Stats (Lessons Completed, Quizzes, Badges, Day Streak) |

**Learning Stats row:** 25 Lessons · 12 Quizzes · 92 Badges · 18 Day Streak

**Badge types visible:** Star Learner · Quiz Master

---

### Learn – English

| Screen ID | File | Chapter | Lessons / Activities |
|---|---|---|---|
| SCR-ENG-00 | `english_home_page.dart` | Hub | Chapter list: Alphabets, Simple Words, Colors in English, Listen & Repeat |
| SCR-ENG-01 | `alphabets_page.dart` | Alphabets | ABC Song (Video ♪), Letter Tracing (Book), Alphabet Chart (Activity) |
| SCR-ENG-02 | `simple_words_page.dart` | Simple Words | Words With Pictures (Book), Word Book (Book), Color & Objects (Activity) |
| SCR-ENG-03 | `colors_page.dart` | Colors | Color Names (Book), Color Match (Activity), Color & Objects (Activity) |
| SCR-ENG-04 | `listen_report_page.dart` | Listen & Report | Word Sounds (Video), Animal Sounds (Activity), Repeat After Me (Activity) |

**Lesson types:** Video 🎵 · Book 📖 · Activity 🎮 (each has star-badge difficulty rating)

---

### Learn – Math

| Screen ID | File | Chapter | Lessons / Activities |
|---|---|---|---|
| SCR-MTH-00 | `math_home_page.dart` (to add) | Hub | Chapter list: Numbers, Counting, Shapes, Addition (Intro) |
| SCR-MTH-01 | `numbers_page.dart` | Numbers | Number Chart (Book), Number Song (Video), Tap the Number (Activity), Count & Say (Video) |
| SCR-MTH-02 | `counting_page.dart` | Counting | Count with Pictures (Book), Counting Song (Video), Count & Match (Activity), Count the Objects (Activity) |
| SCR-MTH-03 | `shapes_page.dart` | Shapes | Shapes Names (Book), Shapes Song (Video), Match the Shapes (Activity), Find the Shape (Activity) |
| SCR-MTH-04 | `addition_page.dart` | Addition | Add with Objects (Book), Addition Song (Video), Add & Tap (Activity) |

---

### Learn – Science

| Screen ID | File | Chapter | Lessons / Activities |
|---|---|---|---|
| SCR-SCI-00 | `science_home_page.dart` (to add) | Hub | Chapter list: Living & Non-Living, Animals, Plants, Human Body, Water & Air |
| SCR-SCI-01 | `living_nonliving_page.dart` | Living & Non-Living | Living Things (Book), Non-Living Things (Book), Living or Not? (Activity), Living Things (Video) |
| SCR-SCI-02 | `animals_page.dart` | Animals | Animal Names (Book), Animal Sounds (Video), Match the Animals (Activity), Animals Song (Video) |
| SCR-SCI-03 | `plants_page.dart` | Plants | Parts of a Plant (Book), Plants Around Us (Book), Draw a Plant (Activity), Plants Song (Video) |
| SCR-SCI-04 | `human_body_page.dart` | Human Body | Body Parts (Book), Body Parts Song (Video), Touch & Learn (Activity), Match Body Parts (Activity) |
| SCR-SCI-05 | `water_air_page.dart` | Water & Air | Uses of Water (Book), Air Around Us (Book), Water Song (Video), Clean Water Activity (Activity) |

---

### Learn – Art & Craft

#### Creative Drawing sub-feature

| Screen ID | File | Description |
|---|---|---|
| SCR-ART-00 | `art_craft_home_page.dart` (to add) | Hub: Creative Drawing, Color & Create, Make a Scene, Fold & Create |
| SCR-ART-01 | `creative_drawing_page.dart` | Lesson list: Draw a Sun, Draw a Tree, Draw a Car, Draw a Home |
| SCR-ART-02 | `draw_sun_page.dart` | Step-by-step: big circle → small lines → circles + smile |
| SCR-ART-03 | `draw_tree_page.dart` | Step-by-step: two curved vertical lines → cloud shape on top → curved inside lines (leaves) |
| SCR-ART-04 | `draw_bicycle_page.dart` | Step-by-step: curved line → straight line under → two big circles (wheels) → small rectangles (windows) |
| SCR-ART-05 | `draw_home_page.dart` | Step-by-step: big rectangle → long straight line → triangle on top (roof) → small rectangle (door) → small squares (windows) |

#### Color & Create (Coloring) sub-feature

| Screen ID | File | Description |
|---|---|---|
| SCR-COL-00 | `color_create_page.dart` | Chapter list: Color the Tree, Color the Animal, Color My Home, Color the Big Balloon |
| SCR-COL-01 | `color_tree_page.dart` | Coloring canvas – tree outline; palette: brown, green, dark |
| SCR-COL-02 | `color_animal_page.dart` | Coloring canvas – elephant/animal outline; palette: grey, dark, etc. |
| SCR-COL-03 | `color_home_page.dart` | Coloring canvas – house outline; palette: brown, red, White, light blue |
| SCR-COL-04 | `color_balloon_page.dart` | Coloring canvas – hot-air balloon; palette: brown, red, white, blue, green |

Coloring toolbar: Zoom in · Zoom out · Undo · Download

#### Make a Scene sub-feature

| Screen ID | File | Description |
|---|---|---|
| SCR-SCENE-00 | `make_scene_page.dart` | Chapter list: Create a Park, Build a Farm, Make a Birthday Party, Decorate a Classroom |
| SCR-SCENE-01 | `create_park_page.dart` | Drag-and-drop scene builder – park background |
| SCR-SCENE-02 | `build_farm_page.dart` | Drag-and-drop scene builder – farm background |
| SCR-SCENE-03 | `birthday_party_page.dart` | Scene builder – birthday party |
| SCR-SCENE-04 | `classroom_page.dart` | Scene builder – classroom |

Scene builder toolbar: sticker elements row at top

#### Fold & Create (Origami) sub-feature

| Screen ID | File | Description |
|---|---|---|
| SCR-FOLD-00 | `fold_create_page.dart` | Chapter list: Boat, Aeroplane, Hat, Fish, Flower |

---

### Quiz

#### Quiz Home

| Screen ID | File | Description |
|---|---|---|
| SCR-QZ-00 | `quiz_home_page.dart` | Grid of quiz cards: Alphabet Quiz, Color Quiz, Numbers Quiz, Animals Quiz |

**Quiz cards visible:** Alphabet Quiz (English · Beginner) · Color Quiz (English · Beginner) · Numbers Quiz (Math · Beginner) · Animals Quiz (Science)

#### Quiz Question Page (shared, parameterised by quiz)

| Screen ID | File | Description |
|---|---|---|
| SCR-QZ-01 | `quiz_question_page.dart` | Reusable question screen; renders question text/image + answer options; shows progress counter (e.g., "1/4 questions") and score top-right |

**Question UI elements:**
- Top bar: `< Quiz` back nav · question progress (e.g., `1/4 questions`) · score badge
- Body: illustration (photo/3-D image) above question text
- Answers: 2-column grid of option cards (4 choices) OR True / False pair
- Bottom: `Submit` button · `Next` · `Back` navigation row

#### English Quiz — Question Types Observed

| Q# | Image Shown | Question Template | Answer Type | Options (sample) |
|---|---|---|---|---|
| 1 | School bus | `__ you get to school?` | 4-choice | What / Struck / How / Where |
| 2 | Monkey | `This is a ___` | 4-choice | Buffalo / Goat / Bear / Monkey |
| 3 | Book | `This is a book` | True / False | True / False |
| 4 | Fish (betta) | `It fish can fly` | True / False | True / False |
| 5 | Sun + flames | `The sun is hot` | True / False | True / False |
| 6 | Backpack | Fill in the sentence to make a correct sentence | 4-choice | He / Is / The / Is |
| 7 | Dog | Fill in the sentence to make a correct sentence | 4-choice | The / Is / dog / running |
| 8 | Apple | Fill in the sentence to make a correct sentence | 4-choice | is / apple / red / (4th) |

#### Color Quiz — Question Types Observed

| Q# | Image Shown | Question Template | Answer Type | Options (sample) |
|---|---|---|---|---|
| 1 | Carrot | `The carrot is ___` | 4-choice | Pink / Red / Orange / White |
| 2 | Grass | `Grass is blue` | True / False | True / False |
| 3 | Robot/toy | `Identify the Odd Color` | 4-choice | Pink / Red / Pink / Banana |
| 4 | Night-sky scene | `Complete the sentence` | 4-choice | Pink / Red / Blue / Banana |
| 5 | Milk carton | `Match the Color to Object` | 4-choice | Much / White / Orange / Yellow |
| 6 | Apples | `Match the Color to Object` | 4-choice | Apple / Orange / Green / Yellow |
| 7 | Bananas | `Which one is different?` | 4-choice | Apple / Orange / Yellow / (4th) |
| 8 | Rain clouds | `Skies are grey` | True / False | True / False |
| 9 | Strawberries | `The strawberry is ___` | 4-choice | Pink / Blue / Red / Blue |
| 10 | Dark grain bag | `The strawberry is ___` | 4-choice | Red / Blue / Black / Yellow |
| 11 | Grass/field | `True or False` | True / False | True / False |
| 12 | Wooden table | `Identify the Odd Color` | 4-choice | Red / Blue / Green / Table |

#### Numbers Quiz — Question Types Observed

| Q# | Image Shown | Question Template | Answer Type | Options (sample) |
|---|---|---|---|---|
| 1 | Number sequence display | `1, 4, 6, __` (Fill the blank) | 4-choice | 7 / 8 / 9 / 5 |
| 2 | Number sequence display | `13, 6, 1, __` (Fill the blank) | 4-choice | 6 / 4 / 4 / 10 |
| 3 | Number sequence display | `__, comes before 18` | 4-choice | 13 / 14 / 14 / 10 |
| 4 | Objects on scale | `14 is greater than 6` | True / False | True / False |
| 5 | Objects on scale | `15 it equals 14` | True / False | True / False |
| 6 | True/False display | `27 is an even number` | True / False | True / False |
| 7 | — | `Compare Numbers` | 4-choice | 10 / 5 / 8 / 9 |
| 8 | — | `Find the Pattern` | 4-choice | 10 / 10 / 10 / 10 |
| 9 | Red balloon | `Read Numbers` (numeral recognition) | 4-choice | 5 / 4 / 3 / 4 |

#### Animals Quiz — Question Types Observed

| Q# | Image Shown | Question Template | Answer Type | Options (sample) |
|---|---|---|---|---|
| 1 | Elephant | `Identify the Animal` / `What animal is this?` | 4-choice | Tiger / Elephant / Cat / Dog |
| 2 | Lion | `Animal Name` / `Where does a lion live?` | 4-choice | Home / Water / Jungle / Tree |
| 3 | Rabbit | `What does a rabbit like to eat?` | 4-choice | Hay / Mud / Carrot / Cake |
| 4 | Puppy | `What is a baby dog called?` | 4-choice | Chick / Calf / Puppy / Kitten |
| 5 | Kangaroo | `Which animal can jump?` | 4-choice | Kangaroo / Elephant / Turtle / Cow |
| 6 | Clown fish | `True or False` (fish lives on land) | True / False | True / False |
| 7 | Scene with animals | `Which one is different?` | 4-choice | Dog / Cat / Car / Cow |
| 8 | Pond/water scene | `Which animal lives in water?` | 4-choice | Horse / Fish / Goat / Lion |
| 9 | Wild animals scene | `Which one is a wild animal?` | 4-choice | Cat / Dog / Goat / Tiger |
| 10 | Giraffe | `Which animal has a very long neck?` | 4-choice | Cat / Dog / Giraffe / Bear |
| 11 | Farm scene | `Name Match Question` | 4-choice | Sparrow / Penguin / Cow / (4th) |

---

### Stories

| Screen ID | File | Description |
|---|---|---|
| SCR-STR-00 | `stories_list_page.dart` | Search bar + vertical list of stories |
| SCR-STR-01 | `story_detail_page.dart` | Scrollable story reader: title card → full-text paragraphs interspersed with character illustrations → "Moral" footer |

#### Story Detail — Confirmed Story Content

| Story | Protagonist | Theme / Moral | Pages (approx) | Illustration Style |
|---|---|---|---|---|
| **Bunny's Big Day** | Bunny (white rabbit) | Creativity, sharing, friendship | ~10 | Bunny in meadow + colourful scenes |
| **Ellie the Kind Elephant** | Ellie (elephant) | Kindness, helping others | ~10 | Elephant with small friends in forest |
| **Chicky Learns to Walk** | Chicky (yellow chick) | Perseverance, trying again | ~10 | Chick with mother hen, farm setting |
| **The Shining Star** | Little star | Self-belief, shining bright | ~10 | Star in night sky with moon and clouds |
| **Teddy's Lost Button** | Teddy (stuffed bear) | Problem solving, friendship | ~10 | Teddy with small animals, warm indoor |

**Story Detail UI elements:**
- App bar: `< Story` back arrow · story title centred · yellow-green background
- Body: scrollable column — paragraph text blocks + full-width illustration images alternating
- Moral block at bottom: bold **Moral:** label + moral text
- Audio play button (floating or inline) for narration

**Stories visible in list:** Bunny's Big Day · Ellie the Kind Elephant · Chicky Learns to Walk · The Shining Star · Teddy's Lost Button

---

### Events

| Screen ID | File | Description |
|---|---|---|
| SCR-EVT-00 | `upcoming_events_page.dart` | Tab view – Upcoming events list |
| SCR-EVT-01 | `past_events_page.dart` | Tab view – Past events list |

**Upcoming events visible:** Annual Sports Day · Science Exhibition · Art Competition · Cultural Fest

**Past events visible:** Republic Day Celebrations · Dance Fest

---

### Games

| Screen ID | File | Description |
|---|---|---|
| SCR-GAM-00 | `fun_games_page.dart` | Games hub with game cards |
| SCR-GAM-01 | `match_blocks_game.dart` | Match the Alphabet game |
| SCR-GAM-02 | `count_blocks_game.dart` | Count Objects game |

---

### Progress

| Screen ID | File | Description |
|---|---|---|
| SCR-PRG-00 | `progress_page.dart` | Stats chart: completion bars per subject, badges earned |

---

## Summary Count

| Feature | Screen Count | Notes |
|---|---|---|
| Auth | 2 | Login, Signup |
| Shell (Splash + Main Tab) | 2 | |
| Dashboard | 1 | |
| Profile | 1 | |
| English | 5 | Hub + 4 chapters |
| Math | 5 | Hub + 4 chapters |
| Science | 6 | Hub + 5 chapters |
| Art & Craft (Drawing) | 6 | Hub + 5 drawing steps |
| Art & Craft (Color & Create) | 5 | Hub + 4 coloring canvases |
| Art & Craft (Make a Scene) | 5 | Hub + 4 scene builders |
| Art & Craft (Fold & Create) | 1 | Chapter list only |
| Quiz Home | 1 | |
| Quiz Questions (shared page) | 1 | Parameterised by quiz type |
| Stories List | 1 | |
| Story Detail | 5 | One per story |
| Events | 2 | Upcoming + Past tabs |
| Games | 3 | Hub + 2 games |
| Progress | 1 | |
| **Total** | **53** | *+4 from new story detail screens* |

> **Updated:** Screen count revised to 53 after batch-2 screenshot analysis confirmed 5 distinct story detail pages and quiz question screen details.
