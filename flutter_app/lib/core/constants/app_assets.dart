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
  static const String learnEnglish = '${_webLearnIcons}english.png';
  static const String learnMath = '${_webLearnIcons}math.png';
  static const String learnScience = '${_webLearnIcons}science.png';
  static const String learnArts = '${_webLearnIcons}arts.png';
  static const String learnAlphabet = '${_webLearnIcons}alphabet.png';
  static const String learnObjects = '${_webLearnIcons}object.png';

  /// Draw a Tree activity — step illustrations (`web/icons/learn/step*.png`).
  static const String learnDrawTreeStep1 = '${_webLearnIcons}step1.png';
  static const String learnDrawTreeStep2 = '${_webLearnIcons}step2.png';
  static const String learnDrawTreeStep3 = '${_webLearnIcons}step3.png';

  // English subject (english_sub) artwork
  static const String englishAlphabet = '${_webEnglishSubIcons}alphabet.png';
  static const String englishSimpleWords = '${_webEnglishSubIcons}simple_word.png';
  static const String englishColors = '${_webEnglishSubIcons}colors.png';
  static const String englishListen = '${_webEnglishSubIcons}listen.png';
  static const String englishHuggy = '${_webEnglishSubIcons}huggy.png';
  static const String englishAbcSong = '${_webEnglishSubIcons}abc_song.png';
  static const String englishLetterTrace = '${_webEnglishSubIcons}letter_trace.png';
  static const String englishAlphaChart = '${_webEnglishSubIcons}alpha_chart.png';
  static const String englishColorMatch = '${_webEnglishSubIcons}color_match.png';
  static const String englishColorObj = '${_webEnglishSubIcons}color_obj.png';
  static const String englishAnimalSound = '${_webEnglishSubIcons}animal_sound.png';
  static const String englishRepeatAfter = '${_webEnglishSubIcons}repeat_after.png';

  // Math subject (math_sub) artwork
  static const String mathNumbers = '${_webMathSubIcons}numbers.png';
  static const String mathCount = '${_webMathSubIcons}count.png';
  static const String mathShapes = '${_webMathSubIcons}shapes.png';
  static const String mathAddition = '${_webMathSubIcons}addition.png';
  static const String mathNumberChart = '${_webMathSubIcons}number_chart.png';
  static const String mathCountCharts = '${_webMathSubIcons}count_charts.png';

  // Science subject (science_sub) artwork
  static const String scienceLiving = '${_webScienceSubIcons}living.png';
  static const String scienceAnimals = '${_webScienceSubIcons}animals.png';
  static const String sciencePlants = '${_webScienceSubIcons}plants.png';
  static const String scienceWater = '${_webScienceSubIcons}water.png';
  static const String scienceHumanBody = '${_webScienceSubIcons}human_body.png';

  // Art & Craft (arts_craft) artwork
  static const String artsCraftDrawSun = '${_webArtsCraftIcons}draw_sun.png';
  static const String artsCraftDrawTree = '${_webArtsCraftIcons}draw_tree.png';
  static const String artsCraftDrawCar = '${_webArtsCraftIcons}draw_car.webp';
  static const String artsCraftDrawHome = '${_webArtsCraftIcons}draw_home.png';

  /// Color & Create chapter thumbnails
  static const String artsCraftColorTree = '${_webArtsCraftIcons}color_tree.png';
  /// Color & Create list thumbnail for “Color the Animal” (not the activity PNG).
  static const String artsCraftColorAnimalThumb =
      '${_webArtsCraftIcons}color_animal.png';
  /// Color the Animal activity image (`color_elephant.png`).
  static const String artsCraftColorAnimal =
      '${_webArtsCraftIcons}color_elephant.png';
  static const String artsCraftColorHome = '${_webArtsCraftIcons}color_home.png';
  /// Color My Home activity image (`home.png`).
  static const String artsCraftColorMyHomeLineArt =
      '${_webArtsCraftIcons}home.png';
  static const String artsCraftColorBig = '${_webArtsCraftIcons}color_big.png';
  /// Color the Big Balloon activity image (`color_ballon.png`).
  static const String artsCraftColorBigLineArt =
      '${_webArtsCraftIcons}color_ballon.png';
  /// Color the Tree activity image (`tree.png`).
  static const String artsCraftColorTheTree = '${_webArtsCraftIcons}tree.png';

  /// Fold & Create chapter thumbnails (`airoplaane.png` matches asset filename).
  static const String artsCraftFoldBoat = '${_webArtsCraftIcons}boat.png';
  static const String artsCraftFoldAeroplane = '${_webArtsCraftIcons}airoplaane.png';
  static const String artsCraftFoldHat = '${_webArtsCraftIcons}hat.png';
  static const String artsCraftFoldFish = '${_webArtsCraftIcons}fish.png';
  static const String artsCraftFoldFlower = '${_webArtsCraftIcons}flower.png';

  /// Make a Scene chapter thumbnails (`web/icons/arts_craft/make_scene/`).
  static const String _webMakeScene = '${_webArtsCraftIcons}make_scene/';
  static const String artsCraftMakeScenePark = '${_webMakeScene}create_park.png';
  /// “Build your dream park” activity background (`dream_park.png`).
  static const String artsCraftMakeSceneDreamPark =
      '${_webMakeScene}dream_park.png';
  /// "Build a Farm" tab — `build_form.png`.
  static const String artsCraftMakeSceneBuildFarm =
      '${_webMakeScene}build_form.png';
  /// Build a Farm / farm scene background (`dream_form.png`).
  static const String artsCraftMakeSceneDreamFarm =
      '${_webMakeScene}dream_form.png';
  static const String artsCraftMakeSceneStickerCow =
      '${_webMakeScene}cow.png';
  /// Sticker asset (`former.png` — farmer character).
  static const String artsCraftMakeSceneStickerFarmer =
      '${_webMakeScene}former.png';
  static const String artsCraftMakeSceneStickerSheep =
      '${_webMakeScene}sheep.png';
  static const String artsCraftMakeSceneStickerTractor =
      '${_webMakeScene}tractor.png';
  static const String artsCraftMakeSceneBirthday =
      '${_webMakeScene}birthday_party.png';
  /// Make a Birthday Party — background (`birthday.png`).
  static const String artsCraftMakeSceneDreamBirthday =
      '${_webMakeScene}birthday.png';
  /// Sticker (`ballons.png` — spelling matches asset on disk).
  static const String artsCraftMakeSceneStickerBalloons =
      '${_webMakeScene}ballons.png';
  static const String artsCraftMakeSceneStickerFriends =
      '${_webMakeScene}friends.png';
  static const String artsCraftMakeSceneStickerGifts =
      '${_webMakeScene}gifts.png';
  static const String artsCraftMakeSceneStickerCake =
      '${_webMakeScene}cake.png';
  static const String artsCraftMakeSceneClassroom =
      '${_webMakeScene}decorate_classroom.png';
  /// Decorate a Classroom — background (`classroom.png`).
  static const String artsCraftMakeSceneDreamClassroom =
      '${_webMakeScene}classroom.png';
  static const String artsCraftMakeSceneStickerClock =
      '${_webMakeScene}clock.png';
  static const String artsCraftMakeSceneStickerBooks =
      '${_webMakeScene}books.png';
  static const String artsCraftMakeSceneStickerAlphabetChart =
      '${_webMakeScene}alphabet_chart.png';
  static const String artsCraftMakeSceneStickerTeacher =
      '${_webMakeScene}teacher.png';
  /// Create a Park — draggable stickers (same folder).
  static const String artsCraftMakeSceneStickerTree =
      '${_webMakeScene}tree.png';
  static const String artsCraftMakeSceneStickerSwing =
      '${_webMakeScene}swing.png';
  static const String artsCraftMakeSceneStickerSlider =
      '${_webMakeScene}slider.png';
  static const String artsCraftMakeSceneStickerFlowers =
      '${_webMakeScene}flowers.png';

  // Quiz page artwork
  static const String quizAlphabet = '${_webQuizIcons}alphs_quiz.png';
  /// English quiz — fill-in illustration (school bus).
  static const String quizVan = '${_webQuizIcons}van.png';
  static const String quizMonkey = '${_webQuizIcons}monkey.png';
  static const String quizBookAnimal = '${_webQuizIcons}book_animal.png';
  static const String quizFish = '${_webQuizIcons}fish.png';
  static const String quizHotSun = '${_webQuizIcons}hot_sun.png';
  static const String quizBag = '${_webQuizIcons}bag.png';
  static const String quizDog = '${_webQuizIcons}dog.png';
  static const String quizApple = '${_webQuizIcons}apple.png';
  /// Color Quiz — fill-in illustrations.
  static const String quizCarrot = '${_assetsQuizIcons}carrot.png';
  static const String quizColorPalette = '${_webQuizIcons}color_pallete.png';
  static const String quizSky = '${_webQuizIcons}sky.png';
  static const String quizGrass = '${_assetsQuizIcons}grass.png';
  static const String quizClouds = '${_webQuizIcons}clouds.png';
  static const String quizBanana = '${_webQuizIcons}banana.png';
  static const String quizMilk = '${_webQuizIcons}milk.png';
  static const String quizCoal = '${_webQuizIcons}coal.png';
  static const String quizAppleSlice = '${_webQuizIcons}slice_appple.png';
  static const String quizStrawberry = '${_webQuizIcons}straberry.png';
  static const String quizTable = '${_webQuizIcons}table.png';
  static const String quizColors = '${_webQuizIcons}color_quiz.png';
  static const String quizNumbers = '${_webQuizIcons}number_quiz.png';
  /// Numbers Quiz — notebook Q&A illustration on each question screen.
  static const String quizNum = '${_webQuizIcons}quiz_num.png';
  /// Numbers Quiz — word problem illustration.
  static const String quizBallon = '${_webQuizIcons}quiz_ballon.png';
  static const String quizAnimals = '${_webQuizIcons}animal_quiz.png';
  /// Animals Quiz — 3D animal illustrations (`web/icons/quiz/`).
  static const String quizElephant = '${_webQuizIcons}elephant.png';
  static const String quizLion = '${_webQuizIcons}lion.png';
  static const String quizRabbit = '${_webQuizIcons}rabit.png';
  static const String quizPuppy = '${_webQuizIcons}puppy.png';
  static const String quizZoo = '${_webQuizIcons}zoo.png';
  static const String quizAniFish = '${_webQuizIcons}ani_fish.png';
  /// Winter pond / water scene (`rever.png` on disk).
  static const String quizRever = '${_webQuizIcons}rever.png';

  // Events page artwork
  static const String eventSports = '${_webEventsIcons}sports.png';
  static const String eventSciExhibition = '${_webEventsIcons}sci_exhibition.png';
  static const String eventArtComp = '${_webEventsIcons}art_comp.png';
  static const String eventCultural = '${_webEventsIcons}cultural.png';
  static const String eventRepublic = '${_webEventsIcons}republic.png';
  static const String eventDance = '${_webEventsIcons}dance.png';

  // Stories page artwork
  static const String storyBunnysDay = '${_webStoriesIcons}bunnys_day.png';
  /// "Bunny's Big Day" scenes — `bunny_s_day/` is listed explicitly in pubspec (no apostrophe; bundles reliably).
  static const String _bunnyDayScenes = '${_webStoriesIcons}bunny_s_day/';
  static const String storyBunnyDayFirst = '${_bunnyDayScenes}first.png';
  static const String storyBunnyDaySecond = '${_bunnyDayScenes}second.png';
  static const String storyBunnyDayThird = '${_bunnyDayScenes}third.png';
  static const String storyBunnyDayFourth = '${_bunnyDayScenes}fourth.png';
  static const String storyBunnyDayFifth = '${_bunnyDayScenes}fifth.png';
  /// "Ellie the Kind Elephant" — `web/icons/stories/Elli's story/` (quoted in pubspec.yaml).
  static const String _elliStoryScenes = "${_webStoriesIcons}Elli's story/";
  static const String storyEllieSceneFirst = '${_elliStoryScenes}first.png';
  static const String storyEllieSceneSecond = '${_elliStoryScenes}second.png';
  static const String storyEllieSceneThird = '${_elliStoryScenes}third.png';
  static const String storyEllieSceneFourth = '${_elliStoryScenes}fourth.png';
  static const String storyEllieSceneFifth = '${_elliStoryScenes}fifth.png';
  /// "Chicky Learns to Walk" — `web/icons/stories/chicky_walk/` (explicit in pubspec, same pattern as bunny_s_day).
  static const String _chickyWalkScenes = '${_webStoriesIcons}chicky_walk/';
  static const String storyChickyWalkOne = '${_chickyWalkScenes}one.png';
  static const String storyChickyWalkTwo = '${_chickyWalkScenes}two.png';
  static const String storyChickyWalkThree = '${_chickyWalkScenes}three.png';
  static const String storyChickyWalkFour = '${_chickyWalkScenes}four.png';
  static const String storyChickyWalkFive = '${_chickyWalkScenes}five.png';
  /// "The Shining Star" — `web/icons/stories/shining_star/` (explicit in pubspec).
  static const String _shiningStarScenes = '${_webStoriesIcons}shining_star/';
  static const String storyShiningStarOne = '${_shiningStarScenes}one.png';
  static const String storyShiningStarTwo = '${_shiningStarScenes}two.png';
  static const String storyShiningStarThree = '${_shiningStarScenes}three.png';
  static const String storyShiningStarFour = '${_shiningStarScenes}four.png';
  static const String storyShiningStarFive = '${_shiningStarScenes}five.png';
  /// "Teddy's Lost Button" — `web/icons/stories/teddy_s_button/` (explicit in pubspec).
  static const String _teddyButtonScenes = '${_webStoriesIcons}teddy_s_button/';
  static const String storyTeddyButtonOne = '${_teddyButtonScenes}one.png';
  static const String storyTeddyButtonTwo = '${_teddyButtonScenes}two.png';
  static const String storyTeddyButtonThree = '${_teddyButtonScenes}three.png';
  static const String storyTeddyButtonFour = '${_teddyButtonScenes}four.png';
  static const String storyTeddyButtonFive = '${_teddyButtonScenes}five.png';
  static const String storyChicky = '${_webStoriesIcons}chicky.png';
  static const String storyElie = '${_webStoriesIcons}elie.png';
  static const String storyShiningStar = '${_webStoriesIcons}shining_star.png';
  static const String storyTeddy = '${_webStoriesIcons}teddy.png';

  // Avatar
  static const String avatarDefault = '${_webHomeIcons}profile_pic.svg';

  // Coin icon
  static const String iconCoin = '${_webHomeIcons}Coin.svg';
  static const String iconSmile = '${_webHomeIcons}smile.svg';

  // Search/Mic icons
  static const String iconSearch = '${_webHomeIcons}search.svg';
  static const String iconMic = '${_webHomeIcons}mic_iocn.svg';

  // Profile tab artwork
  static const String profileBadgeStar = '${_profileIcons}star.png';
  static const String profileBadgePrize = '${_profileIcons}prize.png';
  static const String profileStatLessons = '${_profileIcons}prize.png';
  static const String profileStatQuizzes = '${_profileIcons}achieve.png';
  static const String profileStatScore = '${_profileIcons}goal.png';
  static const String profileStatStreak = '${_profileIcons}fire.png';
  static const String profileNavHome = '${_profileIcons}home2.png';
  static const String profileNavSmile = '${_profileIcons}smile.png';

  // Animations
  static const String splashAnimation = '${_animations}splash_logo.json';
  static const String starBurst = '${_animations}star_burst.json';
  static const String confetti = '${_animations}confetti.json';
}
