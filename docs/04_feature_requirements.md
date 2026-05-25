# Feature Requirements

> Detailed functional requirements for each feature area, derived from UI screenshots.

---

## FR-01 · Authentication

### Login
- Parent/guardian enters email + password.
- "Forgot Password" link.
- On success → navigate to Dashboard.

### Signup
- Fields: Name, Email, Password, Confirm Password, Child Name, Class/Playgroup.
- Validation: email format, password strength, matching passwords.

---

## FR-02 · Dashboard (Home)

| Req ID | Requirement |
|---|---|
| FR-02-01 | Display logged-in child's name and class (e.g., "Aarav Kumar · Class Playgroup") |
| FR-02-02 | Show coin/reward count badge (e.g., 3,200 coins) |
| FR-02-03 | Search bar for quickly finding subjects or stories |
| FR-02-04 | Notification bell icon (top right) |
| FR-02-05 | Quick Access grid: Learn, Quiz, Events, Stories (2×2 grid of coloured cards) |
| FR-02-06 | Hero illustration of child character below Quick Access |
| FR-02-07 | Announcements section: scrollable list of school notices |
| FR-02-08 | Announcement items show: title, short description, date, deep-link arrow |
| FR-02-09 | Bottom navigation with Home (active) and Profile tabs |

---

## FR-03 · Profile

| Req ID | Requirement |
|---|---|
| FR-03-01 | Display child avatar (3-D character illustration) |
| FR-03-02 | Show Name, School/Class |
| FR-03-03 | Display coin/reward balance |
| FR-03-04 | "My Badges" section with horizontal scrollable badge cards (e.g., Star Learner, Quiz Master) |
| FR-03-05 | "View All" link for badges |
| FR-03-06 | Learning Stats row: Lessons Completed, Quizzes, Badges, Day Streak |
| FR-03-07 | "Announcements" section below stats (same as Home announcements) |

---

## FR-04 · Learn Hub

| Req ID | Requirement |
|---|---|
| FR-04-01 | Learn hub page lists four subject cards: English, Math, Science, Art & Craft |
| FR-04-02 | Each subject card shows subject name, short description, chapter count |
| FR-04-03 | Tapping a subject navigates to that subject's Home page |

---

## FR-05 · Learn – English

| Req ID | Requirement |
|---|---|
| FR-05-01 | English Home shows four chapters: Alphabets, Simple Words, Colors in English, Listen & Repeat |
| FR-05-02 | Each chapter row shows: thumbnail, title, description, chapter number, star difficulty badge |
| FR-05-03 | Chapter detail header shows: "Complete the chapter and earn N star badge(s)!" |
| FR-05-04 | **Alphabets** chapter lessons: ABC Song (Video), Letter Tracing (Book), Alphabet Chart (Activity) |
| FR-05-05 | **Simple Words** lessons: Words With Pictures (Book), Word Book (Book), Color & Objects (Activity) |
| FR-05-06 | **Colors** lessons: Color Names (Book), Color Match (Activity), Color & Objects (Activity) |
| FR-05-07 | **Listen & Report** lessons: Word Sounds (Video), Animal Sounds (Activity), Repeat After Me (Activity) |
| FR-05-08 | Video lessons open inline or full-screen video player |
| FR-05-09 | Book lessons open an illustrated page-by-page reader |
| FR-05-10 | Activity lessons open an interactive exercise |
| FR-05-11 | Each lesson shows star completion indicators |

---

## FR-06 · Learn – Math

| Req ID | Requirement |
|---|---|
| FR-06-01 | Math Home shows four chapters: Numbers, Counting, Shapes, Addition (Intro) |
| FR-06-02 | **Numbers** lessons: Number Chart (Book), Number Song (Video), Tap the Number (Activity), Count & Say (Video) |
| FR-06-03 | **Counting** lessons: Count with Pictures (Book), Counting Song (Video), Count & Match (Activity), Count the Objects (Activity) |
| FR-06-04 | **Shapes** lessons: Shapes Names (Book), Shapes Song (Video), Match the Shapes (Activity), Find the Shape (Activity) |
| FR-06-05 | **Addition** lessons: Add with Objects (Book), Addition Song (Video), Add & Tap (Activity) |
| FR-06-06 | Same lesson interaction types as English (Video / Book / Activity) |

---

## FR-07 · Learn – Science

| Req ID | Requirement |
|---|---|
| FR-07-01 | Science Home shows five chapters: Living & Non-Living, Animals, Plants, Human Body, Water & Air |
| FR-07-02 | **Living & Non-Living**: Living Things (Book), Non-Living Things (Book), Living or Not? (Activity), Living Things (Video) |
| FR-07-03 | **Animals**: Animal Names (Book), Animal Sounds (Video), Match the Animals (Activity), Animals Song (Video) |
| FR-07-04 | **Plants**: Parts of a Plant (Book), Plants Around Us (Book), Draw a Plant (Activity), Plants Song (Video) |
| FR-07-05 | **Human Body**: Body Parts (Book), Body Parts Song (Video), Touch & Learn (Activity), Match Body Parts (Activity) |
| FR-07-06 | **Water & Air**: Uses of Water (Book), Air Around Us (Book), Water Song (Video), Clean Water Activity (Activity) |

---

## FR-08 · Learn – Art & Craft

### FR-08A · Creative Drawing

| Req ID | Requirement |
|---|---|
| FR-08A-01 | Chapter list: Draw a Sun, Draw a Tree, Draw a Car, Draw a Home |
| FR-08A-02 | Each drawing lesson shows numbered step-by-step instructions |
| FR-08A-03 | Each step shows descriptive text and a dotted guide illustration |
| FR-08A-04 | **Draw a Sun**: Step 1 – big circle; Step 2 – small lines; Step 3 – add 2 small circles and smile |
| FR-08A-05 | **Draw a Tree**: Step 1 – two curved vertical lines down; Step 2 – big cloud-like curved shape on top; Step 3 – curved lines inside (leaf texture) |
| FR-08A-06 | **Draw a Bicycle**: Step 1 – big curved line; Step 2 – long straight line under; Step 3 – two big circles (wheels); Step 4 – two small rectangles (windows) |
| FR-08A-07 | **Draw a Home**: Step 1 – big rectangle; Step 2 – long straight line; Step 3 – triangle on top (roof); Step 4 – small rectangle (door); Step 5 – small squares (windows) |
| FR-08A-08 | "Done" button at bottom to mark step complete |

### FR-08B · Color & Create (Coloring Pages)

| Req ID | Requirement |
|---|---|
| FR-08B-01 | Chapter list: Color the Tree, Color the Animal, Color My Home, Color the Big Balloon |
| FR-08B-02 | Each coloring page shows a black-outline illustration on white canvas |
| FR-08B-03 | Color palette: 6–8 swatches specific to each illustration |
| FR-08B-04 | User taps a color swatch then taps a region to flood-fill it |
| FR-08B-05 | Toolbar: Zoom In (+), Zoom Out (−), Undo, Download/Save |
| FR-08B-06 | "Done" button submits and awards stars |
| FR-08B-07 | Coloring state should be saved locally (resume later) |

### FR-08C · Make a Scene

| Req ID | Requirement |
|---|---|
| FR-08C-01 | Chapter list: Create a Park, Build a Farm, Make a Birthday Party, Decorate a Classroom |
| FR-08C-02 | Each scene has a full-screen illustrated background |
| FR-08C-03 | Scrollable sticker strip at top with draggable elements |
| FR-08C-04 | Child drags stickers onto scene to decorate |
| FR-08C-05 | "Done" button submits scene |
| FR-08C-06 | Scene composition should be savable/shareable |

### FR-08D · Fold & Create (Origami)

| Req ID | Requirement |
|---|---|
| FR-08D-01 | Chapter list: Boat, Aeroplane, Hat, Fish, Flower |
| FR-08D-02 | Each item shows step-by-step folding instructions (image + text) |
| FR-08D-03 | Star badge awarded on completion |

---

## FR-09 · Quiz

### General

| Req ID | Requirement |
|---|---|
| FR-09-01 | Quiz Home lists quiz cards by subject + difficulty |
| FR-09-02 | Available quizzes: **English Quiz**, **Color Quiz**, **Numbers Quiz**, **Animals Quiz** |
| FR-09-03 | Each quiz card shows: title, subject chip, difficulty chip, star rating, illustration |
| FR-09-04 | Search bar on quiz home to filter quizzes |
| FR-09-05 | Quiz session progress shown as `X/N questions` counter + running score badge top-right |
| FR-09-06 | Bottom row: `Back` · `Submit` · `Next` navigation buttons |

### Question Rendering

| Req ID | Requirement |
|---|---|
| FR-09-07 | Question page displays a contextual image/illustration above the question text |
| FR-09-08 | **Mode A – 4-choice**: 2×2 grid of tappable option cards; single-select |
| FR-09-09 | **Mode B – True/False**: 2 large option buttons (True / False) |
| FR-09-10 | **Mode C – Fill-in-the-blank**: sentence with `___` blank; 4-option grid below |
| FR-09-11 | Correct answer → card turns green + checkmark feedback animation |
| FR-09-12 | Wrong answer → card turns red + shake; correct card highlighted |
| FR-09-13 | Score summary screen shown after final question |

### English Quiz — Confirmed Question Types

| Req ID | Question Type | Description |
|---|---|---|
| FR-09-ENG-01 | Fill-in-blank (sentence completion) | e.g., `__ you get to school?` → What / Struck / How / Where |
| FR-09-ENG-02 | Identify (4-choice) | `This is a ___` with animal image → Buffalo / Goat / Bear / Monkey |
| FR-09-ENG-03 | True / False | `This is a book` (image of book) |
| FR-09-ENG-04 | True / False | `It fish can fly` (image of fish) |
| FR-09-ENG-05 | True / False | `The sun is hot` (image of sun) |
| FR-09-ENG-06 | Sentence construction | Arrange words to make correct sentence; image: backpack |
| FR-09-ENG-07 | Sentence construction | Arrange words; image: dog |
| FR-09-ENG-08 | Sentence construction | Arrange words; image: apple |

### Color Quiz — Confirmed Question Types

| Req ID | Question Type | Description |
|---|---|---|
| FR-09-COL-01 | Fill-in-blank | `The carrot is ___` → Pink / Red / **Orange** / White |
| FR-09-COL-02 | True / False | `Grass is blue` → False |
| FR-09-COL-03 | Odd-one-out | `Identify the Odd Color` from a set of swatches |
| FR-09-COL-04 | Sentence completion | `Complete the sentence` about a night-sky scene |
| FR-09-COL-05 | Color-object match | `Match the Color to Object` (milk carton → white) |
| FR-09-COL-06 | Color-object match | `Match the Color to Object` (apples → red/green) |
| FR-09-COL-07 | Odd-one-out | `Which one is different?` (banana set) |
| FR-09-COL-08 | True / False | `Skies are grey` (rain clouds image) |
| FR-09-COL-09 | Fill-in-blank | `The strawberry is ___` → Pink / Blue / **Red** / Blue |
| FR-09-COL-10 | Fill-in-blank | `The [object] is ___` (dark grain bag) → Black |
| FR-09-COL-11 | True / False | About grass/field color |
| FR-09-COL-12 | Odd-one-out | `Identify the Odd Color` (wooden table set) |

### Numbers Quiz — Confirmed Question Types

| Req ID | Question Type | Description |
|---|---|---|
| FR-09-NUM-01 | Sequence completion | `1, 4, 6, __` → 7 / 8 / 9 / 5 |
| FR-09-NUM-02 | Sequence completion | `13, 6, 1, __` |
| FR-09-NUM-03 | Predecessor | `__, comes before 18` |
| FR-09-NUM-04 | True / False | `14 is greater than 6` |
| FR-09-NUM-05 | True / False | `15 equals 14` |
| FR-09-NUM-06 | True / False | `27 is an even number` |
| FR-09-NUM-07 | Compare Numbers | Select the larger/smaller of two numbers |
| FR-09-NUM-08 | Pattern recognition | `Find the Pattern` from a number sequence |
| FR-09-NUM-09 | Numeral reading | `Read Numbers` — identify balloon with written numeral |

### Animals Quiz — Confirmed Question Types

| Req ID | Question Type | Description |
|---|---|---|
| FR-09-ANI-01 | Identify | `What animal is this?` (elephant image) → Tiger / **Elephant** / Cat / Dog |
| FR-09-ANI-02 | Habitat | `Where does a lion live?` → Home / Water / **Jungle** / Tree |
| FR-09-ANI-03 | Diet | `What does a rabbit like to eat?` → Hay / Mud / **Carrot** / Cake |
| FR-09-ANI-04 | Baby name | `What is a baby dog called?` → Chick / Calf / **Puppy** / Kitten |
| FR-09-ANI-05 | Ability | `Which animal can jump?` → **Kangaroo** / Elephant / Turtle / Cow |
| FR-09-ANI-06 | True / False | `[Fish] lives on land` → False |
| FR-09-ANI-07 | Odd-one-out | `Which one is different?` → Dog / Cat / **Car** / Cow (car is not an animal) |
| FR-09-ANI-08 | Habitat | `Which animal lives in water?` → Horse / **Fish** / Goat / Lion |
| FR-09-ANI-09 | Wild vs. domestic | `Which one is a wild animal?` → Cat / Dog / Goat / **Tiger** |
| FR-09-ANI-10 | Feature | `Which animal has a very long neck?` → Cat / Dog / **Giraffe** / Bear |
| FR-09-ANI-11 | Naming | Species match question (farm scene) → Sparrow / Penguin / **Cow** |


---

## FR-10 · Stories

| Req ID | Requirement |
|---|---|
| FR-10-01 | Stories list page with search bar at top |
| FR-10-02 | Each story row: illustration thumbnail, title, teaser/description text |
| FR-10-03 | 5 stories available: Bunny's Big Day, Ellie the Kind Elephant, Chicky Learns to Walk, The Shining Star, Teddy's Lost Button |
| FR-10-04 | Story detail page: scrollable single-column layout with paragraph text + inline full-width illustrations |
| FR-10-05 | Audio narration playback (floating/inline play button) |
| FR-10-06 | **Moral block** at end of every story: bold "Moral:" label + moral text |
| FR-10-07 | Story detail app bar: yellow-green background, story title centred, back arrow |

### Confirmed Story Morals

| Story | Protagonist | Theme | Moral (observed) |
|---|---|---|---|
| Bunny's Big Day | Bunny (white rabbit) | Creativity & sharing | Friends make everything more fun |
| Ellie the Kind Elephant | Ellie (elephant) | Kindness | Be kind — kindness always comes back |
| Chicky Learns to Walk | Chicky (yellow chick) | Perseverance | Keep trying — you will succeed |
| The Shining Star | Little star | Self-belief | You are special; shine in your own way |
| Teddy's Lost Button | Teddy (stuffed bear) | Problem-solving & friendship | Friends help each other solve problems |


---

## FR-11 · Events

| Req ID | Requirement |
|---|---|
| FR-11-01 | Events page has two tabs: Upcoming / Past Events |
| FR-11-02 | Each event item: title, date, short description, illustration, attendance status |
| FR-11-03 | Upcoming events: Annual Sports Day, Science Exhibition, Art Competition, Cultural Fest |
| FR-11-04 | Past events: Republic Day Celebrations, Dance Fest |
| FR-11-05 | Tap event → event detail page (not yet shown in screenshots) |

---

## FR-12 · Games

| Req ID | Requirement |
|---|---|
| FR-12-01 | Games hub lists game cards |
| FR-12-02 | **Match the Alphabet** – drag-and-match letter blocks |
| FR-12-03 | **Count Objects** – count and select correct number |
| FR-12-04 | Score / reward system per game |

---

## FR-13 · Progress

| Req ID | Requirement |
|---|---|
| FR-13-01 | Progress page shows per-subject completion percentage bars |
| FR-13-02 | Shows total badges earned, current streak, total lessons |
| FR-13-03 | Visual chart (bar/radial) for engagement overview |

---

## FR-14 · Notification

| Req ID | Requirement |
|---|---|
| FR-14-01 | Push notifications for upcoming events |
| FR-14-02 | Notification bell on home screen shows unread badge count |
| FR-14-03 | Tapping notification navigates to relevant event/announcement |

---

## FR-15 · Reward System

| Req ID | Requirement |
|---|---|
| FR-15-01 | Star badges awarded on chapter completion (1–3 stars based on difficulty) |
| FR-15-02 | Coins accumulated per lesson/quiz/activity completed |
| FR-15-03 | Named badges: "Star Learner", "Quiz Master" (more to be defined) |
| FR-15-04 | Badge collection visible on Profile page |
| FR-15-05 | Day streak tracked and displayed |
