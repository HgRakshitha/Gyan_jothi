/// Asset path constants for the Gyan Jyoti app.
/// All paths are relative to the assets/ folder declared in pubspec.yaml.
class AppAssets {
  AppAssets._();

  // Images base path
  static const String _animations = 'assets/animations/';
  static const String _profileIcons = 'assets/icons/profile/';
  static const String _webHomeIcons = 'web/icons/home/';
  static const String _webLearnIcons = 'web/icons/learn/';
  static const String _webQuizIcons = 'web/icons/quiz/';
  /// Bundled under `assets/` so PNGs load reliably on all targets (see carrot/grass).
  static const String _assetsQuizIcons = 'assets/icons/quiz/';
  static const String _webEventsIcons = 'web/icons/events/';
  static const String _webStoriesIcons = 'web/icons/stories/';
  static const String _webEnglishSubIcons = 'web/icons/english_sub/';
  static const String _webMathSubIcons = 'web/icons/math_sub/';
  static const String _webScienceSubIcons = 'web/icons/science_sub/';
  static const String _webArtsCraftIcons = 'web/icons/arts_craft/';

  // Dashboard artwork
  static const String illustrationLearn = '${_webHomeIcons}student_write.svg';
  static const String illustrationQuiz = '${_webHomeIcons}card_img.svg';
  static const String illustrationEvents = '${_webHomeIcons}award.svg';
  static const String illustrationStories = '${_webHomeIcons}book_img.svg';

  // Learn page artwork
  static const String learnEnglish = '${_webLearnIcons}english.webp';
  static const String learnMath = '${_webLearnIcons}math.webp';
  static const String learnScience = '${_webLearnIcons}science.webp';
  static const String learnArts = '${_webLearnIcons}arts.webp';
  static const String learnAlphabet = '${_webLearnIcons}alphabet.webp';
  static const String learnObjects = '${_webLearnIcons}object.webp';

  /// Draw a Tree activity — step illustrations (`web/icons/learn/step*.webp`).
  static const String learnDrawTreeStep1 = '${_webLearnIcons}step1.webp';
  static const String learnDrawTreeStep2 = '${_webLearnIcons}step2.webp';
  static const String learnDrawTreeStep3 = '${_webLearnIcons}step3.webp';

  // English subject (english_sub) artwork
  static const String englishAlphabet = '${_webEnglishSubIcons}alphabet.webp';
  static const String englishSimpleWords = '${_webEnglishSubIcons}simple_word.webp';
  static const String englishColors = '${_webEnglishSubIcons}colors.webp';
  static const String englishListen = '${_webEnglishSubIcons}listen.webp';
  static const String englishHuggy = '${_webEnglishSubIcons}huggy.webp';
  static const String englishAbcSong = '${_webEnglishSubIcons}abc_song.webp';
  static const String englishLetterTrace = '${_webEnglishSubIcons}letter_trace.webp';
  static const String englishAlphaChart = '${_webEnglishSubIcons}alpha_chart.webp';
  static const String englishColorMatch = '${_webEnglishSubIcons}color_match.webp';
  static const String englishColorObj = '${_webEnglishSubIcons}color_obj.webp';
  static const String englishAnimalSound = '${_webEnglishSubIcons}animal_sound.webp';
  static const String englishRepeatAfter = '${_webEnglishSubIcons}repeat_after.webp';

  // Math subject (math_sub) artwork
  static const String mathNumbers = '${_webMathSubIcons}numbers.webp';
  static const String mathCount = '${_webMathSubIcons}count.webp';
  static const String mathShapes = '${_webMathSubIcons}shapes.webp';
  static const String mathAddition = '${_webMathSubIcons}addition.webp';
  static const String mathNumberChart = '${_webMathSubIcons}number_chart.webp';
  static const String mathCountCharts = '${_webMathSubIcons}count_charts.webp';

  // Science subject (science_sub) artwork
  static const String scienceLiving = '${_webScienceSubIcons}living.webp';
  static const String scienceAnimals = '${_webScienceSubIcons}animals.webp';
  static const String sciencePlants = '${_webScienceSubIcons}plants.webp';
  static const String scienceWater = '${_webScienceSubIcons}water.webp';
  static const String scienceHumanBody = '${_webScienceSubIcons}human_body.webp';

  // Art & Craft (arts_craft) artwork
  static const String artsCraftDrawSun = '${_webArtsCraftIcons}draw_sun.webp';
  static const String artsCraftDrawTree = '${_webArtsCraftIcons}draw_tree.webp';
  static const String artsCraftDrawCar = '${_webArtsCraftIcons}draw_car.webp';
  static const String artsCraftDrawHome = '${_webArtsCraftIcons}draw_home.webp';

  /// Color & Create chapter thumbnails
  static const String artsCraftColorTree = '${_webArtsCraftIcons}color_tree.webp';
  /// Color & Create list thumbnail for “Color the Animal” (not the activity PNG).
  static const String artsCraftColorAnimalThumb =
      '${_webArtsCraftIcons}color_animal.webp';
  /// Color the Animal activity image (`color_elephant.webp`).
  static const String artsCraftColorAnimal =
      '${_webArtsCraftIcons}color_elephant.webp';
  static const String artsCraftColorHome = '${_webArtsCraftIcons}color_home.webp';
  /// Color My Home activity image (`home.webp`).
  static const String artsCraftColorMyHomeLineArt =
      '${_webArtsCraftIcons}home.webp';
  static const String artsCraftColorBig = '${_webArtsCraftIcons}color_big.webp';
  /// Color the Big Balloon activity image (`color_ballon.webp`).
  static const String artsCraftColorBigLineArt =
      '${_webArtsCraftIcons}color_ballon.webp';
  /// Color the Tree activity image (`tree.webp`).
  static const String artsCraftColorTheTree = '${_webArtsCraftIcons}tree.webp';

  /// Fold & Create chapter thumbnails (`airoplaane.webp` matches asset filename).
  static const String artsCraftFoldBoat = '${_webArtsCraftIcons}boat.webp';
  static const String artsCraftFoldAeroplane = '${_webArtsCraftIcons}airoplaane.webp';
  static const String artsCraftFoldHat = '${_webArtsCraftIcons}hat.webp';
  static const String artsCraftFoldFish = '${_webArtsCraftIcons}fish.webp';
  static const String artsCraftFoldFlower = '${_webArtsCraftIcons}flower.webp';

  /// Make a Scene chapter thumbnails (`web/icons/arts_craft/make_scene/`).
  static const String _webMakeScene = '${_webArtsCraftIcons}make_scene/';
  static const String artsCraftMakeScenePark = '${_webMakeScene}create_park.webp';
  /// “Build your dream park” activity background (`dream_park.webp`).
  static const String artsCraftMakeSceneDreamPark =
      '${_webMakeScene}dream_park.webp';
  /// "Build a Farm" tab — `build_form.webp`.
  static const String artsCraftMakeSceneBuildFarm =
      '${_webMakeScene}build_form.webp';
  /// Build a Farm / farm scene background (`dream_form.webp`).
  static const String artsCraftMakeSceneDreamFarm =
      '${_webMakeScene}dream_form.webp';
  static const String artsCraftMakeSceneStickerCow =
      '${_webMakeScene}cow.webp';
  /// Sticker asset (`former.webp` — farmer character).
  static const String artsCraftMakeSceneStickerFarmer =
      '${_webMakeScene}former.webp';
  static const String artsCraftMakeSceneStickerSheep =
      '${_webMakeScene}sheep.webp';
  static const String artsCraftMakeSceneStickerTractor =
      '${_webMakeScene}tractor.webp';
  static const String artsCraftMakeSceneBirthday =
      '${_webMakeScene}birthday_party.webp';
  /// Make a Birthday Party — background (`birthday.webp`).
  static const String artsCraftMakeSceneDreamBirthday =
      '${_webMakeScene}birthday.webp';
  /// Sticker (`ballons.webp` — spelling matches asset on disk).
  static const String artsCraftMakeSceneStickerBalloons =
      '${_webMakeScene}ballons.webp';
  static const String artsCraftMakeSceneStickerFriends =
      '${_webMakeScene}friends.webp';
  static const String artsCraftMakeSceneStickerGifts =
      '${_webMakeScene}gifts.webp';
  static const String artsCraftMakeSceneStickerCake =
      '${_webMakeScene}cake.webp';
  static const String artsCraftMakeSceneClassroom =
      '${_webMakeScene}decorate_classroom.webp';
  /// Decorate a Classroom — background (`classroom.webp`).
  static const String artsCraftMakeSceneDreamClassroom =
      '${_webMakeScene}classroom.webp';
  static const String artsCraftMakeSceneStickerClock =
      '${_webMakeScene}clock.webp';
  static const String artsCraftMakeSceneStickerBooks =
      '${_webMakeScene}books.webp';
  static const String artsCraftMakeSceneStickerAlphabetChart =
      '${_webMakeScene}alphabet_chart.webp';
  static const String artsCraftMakeSceneStickerTeacher =
      '${_webMakeScene}teacher.webp';
  /// Create a Park — draggable stickers (same folder).
  static const String artsCraftMakeSceneStickerTree =
      '${_webMakeScene}tree.webp';
  static const String artsCraftMakeSceneStickerSwing =
      '${_webMakeScene}swing.webp';
  static const String artsCraftMakeSceneStickerSlider =
      '${_webMakeScene}slider.webp';
  static const String artsCraftMakeSceneStickerFlowers =
      '${_webMakeScene}flowers.webp';

  // Quiz page artwork
  static const String quizAlphabet = '${_webQuizIcons}alphs_quiz.webp';
  /// English quiz — fill-in illustration (school bus).
  static const String quizVan = '${_webQuizIcons}van.webp';
  static const String quizMonkey = '${_webQuizIcons}monkey.webp';
  static const String quizBookAnimal = '${_webQuizIcons}book_animal.webp';
  static const String quizFish = '${_webQuizIcons}fish.webp';
  static const String quizHotSun = '${_webQuizIcons}hot_sun.webp';
  static const String quizBag = '${_webQuizIcons}bag.webp';
  static const String quizDog = '${_webQuizIcons}dog.webp';
  static const String quizApple = '${_webQuizIcons}apple.webp';
  /// Color Quiz — fill-in illustrations.
  static const String quizCarrot = '${_assetsQuizIcons}carrot.webp';
  static const String quizColorPalette = '${_webQuizIcons}color_pallete.webp';
  static const String quizSky = '${_webQuizIcons}sky.webp';
  static const String quizGrass = '${_assetsQuizIcons}grass.webp';
  static const String quizClouds = '${_webQuizIcons}clouds.webp';
  static const String quizBanana = '${_webQuizIcons}banana.webp';
  static const String quizMilk = '${_webQuizIcons}milk.webp';
  static const String quizCoal = '${_webQuizIcons}coal.webp';
  static const String quizAppleSlice = '${_webQuizIcons}slice_appple.webp';
  static const String quizStrawberry = '${_webQuizIcons}straberry.webp';
  static const String quizTable = '${_webQuizIcons}table.webp';
  static const String quizColors = '${_webQuizIcons}color_quiz.webp';
  static const String quizNumbers = '${_webQuizIcons}number_quiz.webp';
  /// Numbers Quiz — notebook Q&A illustration on each question screen.
  static const String quizNum = '${_webQuizIcons}quiz_num.webp';
  /// Numbers Quiz — word problem illustration.
  static const String quizBallon = '${_webQuizIcons}quiz_ballon.webp';
  static const String quizAnimals = '${_webQuizIcons}animal_quiz.webp';
  /// Animals Quiz — 3D animal illustrations (`web/icons/quiz/`).
  static const String quizElephant = '${_webQuizIcons}elephant.webp';
  static const String quizLion = '${_webQuizIcons}lion.webp';
  static const String quizRabbit = '${_webQuizIcons}rabit.webp';
  static const String quizPuppy = '${_webQuizIcons}puppy.webp';
  static const String quizZoo = '${_webQuizIcons}zoo.webp';
  static const String quizAniFish = '${_webQuizIcons}ani_fish.webp';
  /// Winter pond / water scene (`rever.webp` on disk).
  static const String quizRever = '${_webQuizIcons}rever.webp';

  // Events page artwork
  static const String eventSports = '${_webEventsIcons}sports.webp';
  static const String eventSciExhibition = '${_webEventsIcons}sci_exhibition.webp';
  static const String eventArtComp = '${_webEventsIcons}art_comp.webp';
  static const String eventCultural = '${_webEventsIcons}cultural.webp';
  static const String eventRepublic = '${_webEventsIcons}republic.webp';
  static const String eventDance = '${_webEventsIcons}dance.webp';

  // Stories page artwork
  static const String storyBunnysDay = '${_webStoriesIcons}bunnys_day.webp';
  /// "Bunny's Big Day" scenes — `bunny_s_day/` is listed explicitly in pubspec (no apostrophe; bundles reliably).
  static const String _bunnyDayScenes = '${_webStoriesIcons}bunny_s_day/';
  static const String storyBunnyDayFirst = '${_bunnyDayScenes}first.webp';
  static const String storyBunnyDaySecond = '${_bunnyDayScenes}second.webp';
  static const String storyBunnyDayThird = '${_bunnyDayScenes}third.webp';
  static const String storyBunnyDayFourth = '${_bunnyDayScenes}fourth.webp';
  static const String storyBunnyDayFifth = '${_bunnyDayScenes}fifth.webp';
  /// "Ellie the Kind Elephant" — `web/icons/stories/Elli's story/` (quoted in pubspec.yaml).
  static const String _elliStoryScenes = "${_webStoriesIcons}Elli's story/";
  static const String storyEllieSceneFirst = '${_elliStoryScenes}first.webp';
  static const String storyEllieSceneSecond = '${_elliStoryScenes}second.webp';
  static const String storyEllieSceneThird = '${_elliStoryScenes}third.webp';
  static const String storyEllieSceneFourth = '${_elliStoryScenes}fourth.webp';
  static const String storyEllieSceneFifth = '${_elliStoryScenes}fifth.webp';
  /// "Chicky Learns to Walk" — `web/icons/stories/chicky_walk/` (explicit in pubspec, same pattern as bunny_s_day).
  static const String _chickyWalkScenes = '${_webStoriesIcons}chicky_walk/';
  static const String storyChickyWalkOne = '${_chickyWalkScenes}one.webp';
  static const String storyChickyWalkTwo = '${_chickyWalkScenes}two.webp';
  static const String storyChickyWalkThree = '${_chickyWalkScenes}three.webp';
  static const String storyChickyWalkFour = '${_chickyWalkScenes}four.webp';
  static const String storyChickyWalkFive = '${_chickyWalkScenes}five.webp';
  /// "The Shining Star" — `web/icons/stories/shining_star/` (explicit in pubspec).
  static const String _shiningStarScenes = '${_webStoriesIcons}shining_star/';
  static const String storyShiningStarOne = '${_shiningStarScenes}one.webp';
  static const String storyShiningStarTwo = '${_shiningStarScenes}two.webp';
  static const String storyShiningStarThree = '${_shiningStarScenes}three.webp';
  static const String storyShiningStarFour = '${_shiningStarScenes}four.webp';
  static const String storyShiningStarFive = '${_shiningStarScenes}five.webp';
  /// "Teddy's Lost Button" — `web/icons/stories/teddy_s_button/` (explicit in pubspec).
  static const String _teddyButtonScenes = '${_webStoriesIcons}teddy_s_button/';
  static const String storyTeddyButtonOne = '${_teddyButtonScenes}one.webp';
  static const String storyTeddyButtonTwo = '${_teddyButtonScenes}two.webp';
  static const String storyTeddyButtonThree = '${_teddyButtonScenes}three.webp';
  static const String storyTeddyButtonFour = '${_teddyButtonScenes}four.webp';
  static const String storyTeddyButtonFive = '${_teddyButtonScenes}five.webp';
  static const String storyChicky = '${_webStoriesIcons}chicky.webp';
  static const String storyElie = '${_webStoriesIcons}elie.webp';
  static const String storyShiningStar = '${_webStoriesIcons}shining_star.webp';
  static const String storyTeddy = '${_webStoriesIcons}teddy.webp';

  // Avatar
  static const String avatarDefault = '${_webHomeIcons}profile_pic.svg';

  // Coin icon
  static const String iconCoin = '${_webHomeIcons}Coin.svg';
  static const String iconSmile = '${_webHomeIcons}smile.svg';

  // Search/Mic icons
  static const String iconSearch = '${_webHomeIcons}search.svg';
  static const String iconMic = '${_webHomeIcons}mic_iocn.svg';

  // Profile tab artwork
  static const String profileBadgeStar = '${_profileIcons}star.webp';
  static const String profileBadgePrize = '${_profileIcons}prize.webp';
  static const String profileStatLessons = '${_profileIcons}prize.webp';
  static const String profileStatQuizzes = '${_profileIcons}achieve.webp';
  static const String profileStatScore = '${_profileIcons}goal.webp';
  static const String profileStatStreak = '${_profileIcons}fire.webp';
  static const String profileNavHome = '${_profileIcons}home2.webp';
  static const String profileNavSmile = '${_profileIcons}smile.webp';

  // Animations
  static const String splashAnimation = '${_animations}splash_logo.json';
  static const String starBurst = '${_animations}star_burst.json';
  static const String confetti = '${_animations}confetti.json';
}
