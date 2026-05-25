import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/pages/splash_page.dart';
import '../../features/splash/pages/welcome_page.dart';
import '../../features/dashboard/pages/main_tab_page.dart';
import '../../features/profile/pages/profile_page.dart';
import '../../features/learn/pages/learn_page.dart';
import '../../features/learn/pages/english/english_home_page.dart';
import '../../features/learn/pages/english/alphabets_page.dart';
import '../../features/learn/pages/english/simple_words_page.dart';
import '../../features/learn/pages/english/colors_page.dart';
import '../../features/learn/pages/english/listen_repeat_page.dart';
import '../../features/learn/pages/math/math_home_page.dart';
import '../../features/learn/pages/math/numbers_page.dart';
import '../../features/learn/pages/math/counting_page.dart';
import '../../features/learn/pages/math/shapes_page.dart';
import '../../features/learn/pages/math/addition_page.dart';
import '../../features/learn/pages/science/science_home_page.dart';
import '../../features/learn/pages/science/living_non_living_page.dart';
import '../../features/learn/pages/science/animals_page.dart';
import '../../features/learn/pages/science/plants_page.dart';
import '../../features/learn/pages/science/water_air_page.dart';
import '../../features/learn/pages/science/human_body_page.dart';
import '../../features/learn/pages/art_craft/art_craft_home_page.dart';
import '../../features/learn/pages/art_craft/creative_drawing_page.dart';
import '../../features/learn/pages/art_craft/draw_sun_page.dart';
import '../../features/learn/pages/art_craft/draw_tree_page.dart';
import '../../features/learn/pages/art_craft/draw_car_page.dart';
import '../../features/learn/pages/art_craft/draw_home_page.dart';
import '../../features/learn/pages/art_craft/color_and_create_page.dart';
import '../../features/learn/pages/art_craft/color_activity_placeholder_page.dart';
import '../../features/learn/pages/art_craft/fold_activity_placeholder_page.dart';
import '../../features/learn/pages/art_craft/fold_and_create_page.dart';
import '../../features/learn/pages/art_craft/color_the_tree_page.dart';
import '../../features/learn/pages/art_craft/color_the_animal_page.dart';
import '../../features/learn/pages/art_craft/color_my_home_page.dart';
import '../../features/learn/pages/art_craft/color_the_big_balloon_page.dart';
import '../../features/learn/pages/art_craft/make_a_scene_page.dart';
import '../../features/learn/pages/art_craft/build_a_farm_page.dart';
import '../../features/learn/pages/art_craft/decorate_a_classroom_page.dart';
import '../../features/learn/pages/art_craft/make_a_birthday_party_page.dart';
import '../../features/learn/pages/art_craft/create_a_park_page.dart';
import '../../features/learn/pages/art_craft/scene_activity_placeholder_page.dart';
import '../../features/quiz/pages/alphabet_quiz_monkey_page.dart';
import '../../core/constants/app_assets.dart';
import '../../features/quiz/pages/alphabet_quiz_true_false_page.dart';
import '../../features/quiz/pages/alphabet_quiz_puzzle_page.dart';
import '../../features/quiz/pages/alphabet_quiz_true_false_round_page.dart';
import '../../features/quiz/pages/alphabet_quiz_question_page.dart';
import '../../features/quiz/pages/color_quiz_question_page.dart';
import '../../features/quiz/pages/color_quiz_true_false_page.dart';
import '../../features/quiz/pages/color_quiz_variant_page.dart';
import '../../features/quiz/pages/animals_quiz_question_page.dart';
import '../../features/quiz/pages/numbers_quiz_question_page.dart';
import '../../features/quiz/pages/quiz_page.dart';
import '../../features/quiz/pages/quiz_result_page.dart';
import '../../features/quiz/quiz_answer_tracker.dart';
import '../../features/quiz/data/animals_quiz_questions.dart';
import '../../features/events/pages/events_page.dart';
import '../../features/stories/pages/bunnys_big_day_story_page.dart';
import '../../features/stories/pages/chicky_learns_to_walk_story_page.dart';
import '../../features/stories/pages/ellie_kind_elephant_story_page.dart';
import '../../features/stories/pages/shining_star_story_page.dart';
import '../../features/stories/pages/stories_page.dart';
import '../../features/stories/pages/teddys_lost_button_story_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String learn = '/learn';
  static const String englishHome = '/learn/english';
  static const String alphabets = '/learn/english/alphabets';
  static const String simpleWords = '/learn/english/simple-words';
  static const String colors = '/learn/english/colors';
  static const String listenRepeat = '/learn/english/listen-repeat';
  static const String mathHome = '/learn/math';
  static const String mathNumbers = '/learn/math/numbers';
  static const String mathCounting = '/learn/math/counting';
  static const String mathShapes = '/learn/math/shapes';
  static const String mathAddition = '/learn/math/addition';
  static const String scienceHome = '/learn/science';
  static const String scienceLiving = '/learn/science/living-non-living';
  static const String scienceAnimals = '/learn/science/animals';
  static const String sciencePlants = '/learn/science/plants';
  static const String scienceWaterAir = '/learn/science/water-air';
  static const String scienceHumanBody = '/learn/science/human-body';
  static const String artCraftHome = '/learn/art-craft';
  static const String artCraftCreativeDrawing = '/learn/art-craft/creative-drawing';
  static const String artCraftDrawSun = '/learn/art-craft/draw-sun';
  static const String artCraftDrawTree = '/learn/art-craft/draw-tree';
  static const String artCraftDrawCar = '/learn/art-craft/draw-car';
  static const String artCraftDrawHome = '/learn/art-craft/draw-home';
  static const String artCraftColorAndCreate = '/learn/art-craft/color-and-create';
  static const String artCraftFoldAndCreate = '/learn/art-craft/fold-and-create';
  static const String artCraftColorActivity = '/learn/art-craft/color-activity';
  static const String artCraftFoldActivity = '/learn/art-craft/fold-activity';
  static const String artCraftColorTheTree = '/learn/art-craft/color-the-tree';
  static const String artCraftColorTheAnimal = '/learn/art-craft/color-the-animal';
  static const String artCraftColorMyHome = '/learn/art-craft/color-my-home';
  static const String artCraftColorTheBigBalloon =
      '/learn/art-craft/color-the-big-balloon';
  static const String artCraftMakeScene = '/learn/art-craft/make-a-scene';
  static const String artCraftCreateAPark = '/learn/art-craft/create-a-park';
  static const String artCraftBuildAForm = '/learn/art-craft/build-a-form';
  static const String artCraftMakeABirthdayParty =
      '/learn/art-craft/make-a-birthday-party';
  static const String artCraftDecorateAClassroom =
      '/learn/art-craft/decorate-a-classroom';
  static const String artCraftSceneActivity = '/learn/art-craft/scene-activity';
  static const String quiz = '/quiz';
  /// Score screen after completing a quiz (`?title=&score=&total=`).
  static const String quizResult = '/quiz/result';
  static const String quizQuestion = '/quiz/question';
  static const String quizAlphabet = '/quiz/alphabet';
  static const String quizAlphabet2 = '/quiz/alphabet/2';
  static const String quizAlphabet3 = '/quiz/alphabet/3';
  static const String quizAlphabet4 = '/quiz/alphabet/4';
  static const String quizAlphabet5 = '/quiz/alphabet/5';
  static const String quizAlphabet6 = '/quiz/alphabet/6';
  static const String quizAlphabet7 = '/quiz/alphabet/7';
  static const String quizAlphabet8 = '/quiz/alphabet/8';
  /// Color Quiz (11 fill-in-the-blank questions). Use [quizColorQuestion] for `/quiz/colors/1` … `/quiz/colors/11`.
  static const String quizColor = '/quiz/colors';
  static String quizColorQuestion(int n) => '/quiz/colors/$n';
  static const String quizNumbers = '/quiz/numbers';
  static String quizNumbersQuestion(int n) => '/quiz/numbers/$n';
  /// Animals Quiz (11 questions). Use [quizAnimalsQuestion] for `/quiz/animals/1` … `/quiz/animals/11`.
  static const String quizAnimals = '/quiz/animals';
  static String quizAnimalsQuestion(int n) => '/quiz/animals/$n';
  static const String stories = '/stories';
  static const String storyDetail = '/stories/:id';
  static const String storyBunnyBigDay = '/stories/bunny-big-day';
  static const String storyEllieKindElephant = '/stories/ellie-kind-elephant';
  static const String storyChickyLearnsToWalk = '/stories/chicky-learns-to-walk';
  static const String storyShiningStar = '/stories/shining-star';
  static const String storyTeddysLostButton = '/stories/teddys-lost-button';
  static const String events = '/events';
  static const String games = '/games';
  static const String progress = '/progress';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const MainTabPage(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: AppRoutes.learn,
      builder: (context, state) => const LearnPage(),
    ),
    GoRoute(
      path: AppRoutes.englishHome,
      builder: (context, state) => const EnglishHomePage(),
    ),
    GoRoute(
      path: AppRoutes.alphabets,
      builder: (context, state) => const AlphabetsPage(),
    ),
    GoRoute(
      path: AppRoutes.simpleWords,
      builder: (context, state) => const SimpleWordsPage(),
    ),
    GoRoute(
      path: AppRoutes.colors,
      builder: (context, state) => const ColorsPage(),
    ),
    GoRoute(
      path: AppRoutes.listenRepeat,
      builder: (context, state) => const ListenRepeatPage(),
    ),
    GoRoute(
      path: AppRoutes.mathHome,
      builder: (context, state) => const MathHomePage(),
    ),
    GoRoute(
      path: AppRoutes.mathNumbers,
      builder: (context, state) => const NumbersPage(),
    ),
    GoRoute(
      path: AppRoutes.mathCounting,
      builder: (context, state) => const CountingPage(),
    ),
    GoRoute(
      path: AppRoutes.mathShapes,
      builder: (context, state) => const ShapesPage(),
    ),
    GoRoute(
      path: AppRoutes.mathAddition,
      builder: (context, state) => const AdditionPage(),
    ),
    GoRoute(
      path: AppRoutes.scienceHome,
      builder: (context, state) => const ScienceHomePage(),
    ),
    GoRoute(
      path: AppRoutes.scienceLiving,
      builder: (context, state) => const LivingNonLivingPage(),
    ),
    GoRoute(
      path: AppRoutes.scienceAnimals,
      builder: (context, state) => const AnimalsPage(),
    ),
    GoRoute(
      path: AppRoutes.sciencePlants,
      builder: (context, state) => const PlantsPage(),
    ),
    GoRoute(
      path: AppRoutes.scienceWaterAir,
      builder: (context, state) => const WaterAirPage(),
    ),
    GoRoute(
      path: AppRoutes.scienceHumanBody,
      builder: (context, state) => const HumanBodyPage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftHome,
      builder: (context, state) => const ArtCraftHomePage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftCreativeDrawing,
      builder: (context, state) => const CreativeDrawingPage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftDrawSun,
      builder: (context, state) => const DrawSunPage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftDrawTree,
      builder: (context, state) => const DrawTreePage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftDrawCar,
      builder: (context, state) => const DrawCarPage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftDrawHome,
      builder: (context, state) => const DrawHomePage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftColorAndCreate,
      builder: (context, state) => const ColorAndCreatePage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftFoldAndCreate,
      builder: (context, state) => const FoldAndCreatePage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftColorActivity,
      builder: (context, state) {
        final title = state.extra as String? ?? 'Color';
        return ColorActivityPlaceholderPage(title: title);
      },
    ),
    GoRoute(
      path: AppRoutes.artCraftFoldActivity,
      builder: (context, state) {
        final title = state.extra as String? ?? 'Fold & Create';
        return FoldActivityPlaceholderPage(title: title);
      },
    ),
    GoRoute(
      path: AppRoutes.artCraftColorTheTree,
      builder: (context, state) => const ColorTheTreePage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftColorTheAnimal,
      builder: (context, state) => const ColorTheAnimalPage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftColorMyHome,
      builder: (context, state) => const ColorMyHomePage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftColorTheBigBalloon,
      builder: (context, state) => const ColorTheBigBalloonPage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftMakeScene,
      builder: (context, state) => const MakeAScenePage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftCreateAPark,
      builder: (context, state) => const CreateAParkPage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftBuildAForm,
      builder: (context, state) => const BuildAFarmPage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftMakeABirthdayParty,
      builder: (context, state) => const MakeABirthdayPartyPage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftDecorateAClassroom,
      builder: (context, state) => const DecorateAClassroomPage(),
    ),
    GoRoute(
      path: AppRoutes.artCraftSceneActivity,
      builder: (context, state) {
        final title = state.extra as String? ?? 'Make a Scene';
        return SceneActivityPlaceholderPage(title: title);
      },
    ),
    GoRoute(
      path: AppRoutes.quiz,
      builder: (context, state) => const QuizPage(),
    ),
    GoRoute(
      path: AppRoutes.quizResult,
      builder: (context, state) {
        final q = state.uri.queryParameters;
        final title = q['title'] ?? 'Quiz';
        final results = state.extra as List<QuizQuestionResult>? ?? [];
        final score = results.where((r) => r.isCorrect).length;
        final totalRaw = results.isNotEmpty ? results.length : (int.tryParse(q['total'] ?? '') ?? 1);
        final total = totalRaw.clamp(1, 999);
        final finalScore = results.isNotEmpty ? score : (int.tryParse(q['score'] ?? '') ?? 0);
        return QuizResultPage(
          quizTitle: title,
          results: results,
          score: finalScore.clamp(0, total),
          total: total,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.quizColor,
      redirect: (_, __) => AppRoutes.quizColorQuestion(1),
    ),
    GoRoute(
      path: '/quiz/colors/:n',
      builder: (context, state) {
        final n = int.tryParse(state.pathParameters['n'] ?? '1') ?? 1;
        final q = n.clamp(1, 11);
        if (q == 2) {
          return ColorQuizTrueFalsePage.grass();
        }
        if (q == 3) {
          return const ColorQuizOddColorPage();
        }
        if (q == 4) {
          return const ColorQuizCompleteSentenceSkyPage();
        }
        if (q == 5) {
          return const ColorQuizMatchMilkPage();
        }
        if (q == 6) {
          return const ColorQuizAppleMatchDifferentPage();
        }
        if (q == 7) {
          return ColorQuizTrueFalsePage.banana();
        }
        if (q == 8) {
          return const ColorQuizCloudsFillPage();
        }
        if (q == 10) {
          return ColorQuizTrueFalsePage.coal();
        }
        if (q == 11) {
          return const ColorQuizTableOddDifferentPage();
        }
        return ColorQuizQuestionPage(questionNumber: q);
      },
    ),
    GoRoute(
      path: AppRoutes.quizNumbers,
      redirect: (_, __) => AppRoutes.quizNumbersQuestion(1),
    ),
    GoRoute(
      path: '/quiz/numbers/:n',
      builder: (context, state) {
        final n = int.tryParse(state.pathParameters['n'] ?? '1') ?? 1;
        final q = n.clamp(1, 9);
        return NumbersQuizQuestionPage(questionNumber: q);
      },
    ),
    GoRoute(
      path: AppRoutes.quizAnimals,
      redirect: (_, __) => AppRoutes.quizAnimalsQuestion(1),
    ),
    GoRoute(
      path: '/quiz/animals/:n',
      builder: (context, state) {
        final n = int.tryParse(state.pathParameters['n'] ?? '1') ?? 1;
        final q = n.clamp(1, kAnimalsQuizTotal);
        return AnimalsQuizQuestionPage(questionNumber: q);
      },
    ),
    GoRoute(
      path: AppRoutes.quizAlphabet,
      builder: (context, state) => const AlphabetQuizQuestionPage(),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabet2,
      builder: (context, state) => const AlphabetQuizMonkeyPage(),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabet3,
      builder: (context, state) => const AlphabetQuizTrueFalsePage(),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabet4,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 4,
        imageAssetPath: AppAssets.quizFish,
        imageWidth: 220,
        imageHeight: 172,
        fallback: Icon(
          Icons.set_meal_rounded,
          size: 120,
          color: Color(0xFF1565C0),
        ),
        statement: '“A fish can fly.”',
        submitNextRoute: AppRoutes.quizAlphabet5,
        compactIllustration: true,
        correctAnswerIndex: 1,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabet5,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 5,
        imageAssetPath: AppAssets.quizHotSun,
        imageWidth: 210,
        imageHeight: 198,
        fallback: Icon(
          Icons.wb_sunny_rounded,
          size: 120,
          color: Color(0xFFFFA000),
        ),
        statement: '“The sun is hot.”',
        submitNextRoute: AppRoutes.quizAlphabet6,
        correctAnswerIndex: 0,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabet6,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 6,
        imageAssetPath: AppAssets.quizBag,
        imageWidth: 218,
        imageHeight: 200,
        fallback: Icon(
          Icons.backpack_rounded,
          size: 120,
          color: Color(0xFF8D6E63),
        ),
        bankOrder: ['my', 'is', 'bag', 'This'],
        correctSlotOrder: ['This', 'is', 'my', 'bag'],
        submitNextRoute: AppRoutes.quizAlphabet7,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabet7,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 7,
        imageAssetPath: AppAssets.quizDog,
        imageWidth: 224,
        imageHeight: 200,
        fallback: Icon(
          Icons.pets_rounded,
          size: 120,
          color: Color(0xFF795548),
        ),
        bankOrder: ['The', 'is', 'dog', 'running'],
        correctSlotOrder: ['The', 'dog', 'is', 'running'],
        submitNextRoute: AppRoutes.quizAlphabet8,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabet8,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 8,
        imageAssetPath: AppAssets.quizApple,
        imageWidth: 180,
        imageHeight: 180,
        fallback: Icon(
          Icons.eco_rounded,
          size: 120,
          color: Color(0xFFE53935),
        ),
        bankOrder: ['is', 'This', 'apple', 'red'],
        correctSlotOrder: ['This', 'apple', 'is', 'red'],
      ),
    ),
    GoRoute(
      path: AppRoutes.events,
      builder: (context, state) => const EventsPage(),
    ),
    GoRoute(
      path: AppRoutes.stories,
      builder: (context, state) => const StoriesPage(),
    ),
    GoRoute(
      path: AppRoutes.storyBunnyBigDay,
      builder: (context, state) => const BunnysBigDayStoryPage(),
    ),
    GoRoute(
      path: AppRoutes.storyEllieKindElephant,
      builder: (context, state) => const EllieKindElephantStoryPage(),
    ),
    GoRoute(
      path: AppRoutes.storyChickyLearnsToWalk,
      builder: (context, state) => const ChickyLearnsToWalkStoryPage(),
    ),
    GoRoute(
      path: AppRoutes.storyShiningStar,
      builder: (context, state) => const ShiningStarStoryPage(),
    ),
    GoRoute(
      path: AppRoutes.storyTeddysLostButton,
      builder: (context, state) => const TeddysLostButtonStoryPage(),
    ),
  ],
);
