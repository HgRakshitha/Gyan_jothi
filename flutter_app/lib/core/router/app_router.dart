import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/pages/splash_page.dart';
import '../../features/splash/pages/welcome_carousel_page.dart';
import '../../features/splash/pages/welcome_name_page.dart';
import '../../features/splash/pages/welcome_buddy_page.dart';
import '../../features/splash/pages/welcome_class_page.dart';
import '../../features/splash/pages/welcome_all_done_page.dart';
import '../../shared/pages/task_completion_page.dart';
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
import '../../features/quiz/pages/quiz_sets_page.dart';
import '../../features/quiz/pages/alphabet_quiz_set2_question_page.dart';
import '../../features/quiz/pages/alphabet_quiz_set2_monkey_page.dart';
import '../../features/quiz/pages/alphabet_quiz_set2_true_false_page.dart';
import '../../features/quiz/pages/alphabet_quiz_multiple_choice_round_page.dart';
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
  static const String welcomeBunny = '/welcome/bunny';
  static const String welcomePanda = '/welcome/panda';
  static const String welcomeFox = '/welcome/fox';
  static const String welcomeFinal = '/welcome/final';
  static const String welcomeName = '/welcome/name';
  static const String welcomeBuddy = '/welcome/buddy';
  static const String welcomeClass = '/welcome/class';
  static const String welcomeAllDone = '/welcome/all-done';
  static const String taskCompletion = '/task-completion';
  static const String dashboard = '/dashboard';
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
  static const String artCraftBuildAFarm = '/learn/art-craft/build-a-farm';
  static const String artCraftMakeABirthdayParty =
      '/learn/art-craft/make-a-birthday-party';
  static const String artCraftDecorateAClassroom =
      '/learn/art-craft/decorate-a-classroom';
  static const String artCraftSceneActivity = '/learn/art-craft/scene-activity';
  static const String quiz = '/quiz';
  /// Score screen after completing a quiz (`?title=&score=&total=`).
  static const String quizResult = '/quiz/result';
  static const String quizQuestion = '/quiz/question';
  static const String quizSets = '/quiz/sets';
  static const String quizAlphabet = '/quiz/alphabet';
  static const String quizAlphabet2 = '/quiz/alphabet/2';
  static const String quizAlphabet3 = '/quiz/alphabet/3';
  static const String quizAlphabet4 = '/quiz/alphabet/4';
  static const String quizAlphabet5 = '/quiz/alphabet/5';
  static const String quizAlphabet6 = '/quiz/alphabet/6';
  static const String quizAlphabet7 = '/quiz/alphabet/7';
  static const String quizAlphabet8 = '/quiz/alphabet/8';

  // Alphabet Quiz Set 2 (F to J)
  static const String quizAlphabetSet2_1 = '/quiz/alphabet/set2/1';
  static const String quizAlphabetSet2_2 = '/quiz/alphabet/set2/2';
  static const String quizAlphabetSet2_3 = '/quiz/alphabet/set2/3';
  static const String quizAlphabetSet2_4 = '/quiz/alphabet/set2/4';
  static const String quizAlphabetSet2_5 = '/quiz/alphabet/set2/5';
  static const String quizAlphabetSet2_6 = '/quiz/alphabet/set2/6';
  static const String quizAlphabetSet2_7 = '/quiz/alphabet/set2/7';
  static const String quizAlphabetSet2_8 = '/quiz/alphabet/set2/8';

  // Alphabet Quiz Set 3 (K to O)
  static const String quizAlphabetSet3_1 = '/quiz/alphabet/set3/1';
  static const String quizAlphabetSet3_2 = '/quiz/alphabet/set3/2';
  static const String quizAlphabetSet3_3 = '/quiz/alphabet/set3/3';
  static const String quizAlphabetSet3_4 = '/quiz/alphabet/set3/4';
  static const String quizAlphabetSet3_5 = '/quiz/alphabet/set3/5';
  static const String quizAlphabetSet3_6 = '/quiz/alphabet/set3/6';
  static const String quizAlphabetSet3_7 = '/quiz/alphabet/set3/7';
  static const String quizAlphabetSet3_8 = '/quiz/alphabet/set3/8';

  // Alphabet Quiz Set 4 (P to T)
  static const String quizAlphabetSet4_1 = '/quiz/alphabet/set4/1';
  static const String quizAlphabetSet4_2 = '/quiz/alphabet/set4/2';
  static const String quizAlphabetSet4_3 = '/quiz/alphabet/set4/3';
  static const String quizAlphabetSet4_4 = '/quiz/alphabet/set4/4';
  static const String quizAlphabetSet4_5 = '/quiz/alphabet/set4/5';
  static const String quizAlphabetSet4_6 = '/quiz/alphabet/set4/6';
  static const String quizAlphabetSet4_7 = '/quiz/alphabet/set4/7';
  static const String quizAlphabetSet4_8 = '/quiz/alphabet/set4/8';

  // Alphabet Quiz Set 5 (U to Z Magic)
  static const String quizAlphabetSet5_1 = '/quiz/alphabet/set5/1';
  static const String quizAlphabetSet5_2 = '/quiz/alphabet/set5/2';
  static const String quizAlphabetSet5_3 = '/quiz/alphabet/set5/3';
  static const String quizAlphabetSet5_4 = '/quiz/alphabet/set5/4';
  static const String quizAlphabetSet5_5 = '/quiz/alphabet/set5/5';
  static const String quizAlphabetSet5_6 = '/quiz/alphabet/set5/6';
  static const String quizAlphabetSet5_7 = '/quiz/alphabet/set5/7';
  /// Color Quiz (11 fill-in-the-blank questions). Use [quizColorQuestion] for `/quiz/colors/1` … `/quiz/colors/11`.
  static const String quizColor = '/quiz/colors';
  static String quizColorQuestion(int n) => '/quiz/colors/$n';
  static const String quizNumbers = '/quiz/numbers';
  static String quizNumbersQuestion(int n) => '/quiz/numbers/$n';
  /// Animals Quiz (11 questions). Use [quizAnimalsQuestion] for `/quiz/animals/1` … `/quiz/animals/11`.
  static const String quizAnimals = '/quiz/animals';
  static String quizAnimalsQuestion(int n) => '/quiz/animals/$n';

  // Colors Set 2
  static const String quizColorSet2_1 = '/quiz/colors/set2/1';
  static const String quizColorSet2_2 = '/quiz/colors/set2/2';
  static const String quizColorSet2_3 = '/quiz/colors/set2/3';
  static const String quizColorSet2_4 = '/quiz/colors/set2/4';
  static const String quizColorSet2_5 = '/quiz/colors/set2/5';
  static const String quizColorSet2_6 = '/quiz/colors/set2/6';
  static const String quizColorSet2_7 = '/quiz/colors/set2/7';
  static const String quizColorSet2_8 = '/quiz/colors/set2/8';

  // Numbers Set 2
  static const String quizNumbersSet2_1 = '/quiz/numbers/set2/1';
  static const String quizNumbersSet2_2 = '/quiz/numbers/set2/2';
  static const String quizNumbersSet2_3 = '/quiz/numbers/set2/3';
  static const String quizNumbersSet2_4 = '/quiz/numbers/set2/4';
  static const String quizNumbersSet2_5 = '/quiz/numbers/set2/5';
  static const String quizNumbersSet2_6 = '/quiz/numbers/set2/6';

  // Animals Set 2
  static const String quizAnimalsSet2_1 = '/quiz/animals/set2/1';
  static const String quizAnimalsSet2_2 = '/quiz/animals/set2/2';
  static const String quizAnimalsSet2_3 = '/quiz/animals/set2/3';
  static const String quizAnimalsSet2_4 = '/quiz/animals/set2/4';
  static const String quizAnimalsSet2_5 = '/quiz/animals/set2/5';
  static const String quizAnimalsSet2_6 = '/quiz/animals/set2/6';

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

CustomTransitionPage _buildSlideTransitionPage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        )),
        child: child,
      );
    },
  );
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
      builder: (context, state) => const WelcomeCarouselPage(),
    ),
    GoRoute(
      path: AppRoutes.welcomeName,
      pageBuilder: (context, state) => _buildSlideTransitionPage(
        key: state.pageKey,
        child: const WelcomeNamePage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.welcomeBuddy,
      pageBuilder: (context, state) => _buildSlideTransitionPage(
        key: state.pageKey,
        child: const WelcomeBuddyPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.welcomeClass,
      pageBuilder: (context, state) => _buildSlideTransitionPage(
        key: state.pageKey,
        child: const WelcomeClassPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.welcomeAllDone,
      pageBuilder: (context, state) => _buildSlideTransitionPage(
        key: state.pageKey,
        child: const WelcomeAllDonePage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.taskCompletion,
      builder: (context, state) {
        final coins = state.extra as int? ?? 0;
        return TaskCompletionPage(coinsEarned: coins);
      },
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
      path: AppRoutes.artCraftBuildAFarm,
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
        final title = state.uri.queryParameters['title'] ?? 'Quiz Result';
        final score = int.tryParse(state.uri.queryParameters['score'] ?? '0') ?? 0;
        final total = int.tryParse(state.uri.queryParameters['total'] ?? '0') ?? 0;
        final coins = int.tryParse(state.uri.queryParameters['coins'] ?? '50') ?? 50;
        final results = state.extra as List<QuizQuestionResult>? ?? [];
        return QuizResultPage(
          quizTitle: title,
          score: score,
          total: total,
          coins: coins,
          results: results,
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
      path: AppRoutes.quizSets,
      builder: (context, state) {
        final args = state.extra as QuizSetsPageArgs;
        return QuizSetsPage(args: args);
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
    // ------------------------------------------------------------------------
    // Alphabet Quiz Set 2 (F to J)
    // ------------------------------------------------------------------------
    GoRoute(
      path: AppRoutes.quizAlphabetSet2_1,
      builder: (context, state) => const AlphabetQuizSet2QuestionPage(),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet2_2,
      builder: (context, state) => const AlphabetQuizSet2MonkeyPage(),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet2_3,
      builder: (context, state) => const AlphabetQuizSet2TrueFalsePage(),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet2_4,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 4,
        imageAssetPath: 'assets/icons/quiz/set1/giraffe.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(
          Icons.warning_amber_rounded,
          size: 120,
          color: Color(0xFFF9A825),
        ),
        statement: '“A giraffe has a short neck.”',
        submitNextRoute: AppRoutes.quizAlphabetSet2_5,
        compactIllustration: true,
        correctAnswerIndex: 1, // False
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet2_5,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 5,
        imageAssetPath: 'assets/icons/quiz/set1/elephant.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(
          Icons.emoji_nature_rounded,
          size: 120,
          color: Color(0xFF455A64),
        ),
        statement: '“An elephant has a long trunk.”',
        submitNextRoute: AppRoutes.quizAlphabetSet2_6,
        correctAnswerIndex: 0, // True
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet2_6,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 6,
        imageAssetPath: 'assets/icons/quiz/set1/iguana.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(
          Icons.pest_control_rounded,
          size: 120,
          color: Color(0xFF43A047),
        ),
        bankOrder: ['green', 'iguana', 'An', 'is'],
        correctSlotOrder: ['An', 'iguana', 'is', 'green'],
        submitNextRoute: AppRoutes.quizAlphabetSet2_7,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet2_7,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 7,
        imageAssetPath: 'assets/icons/quiz/set1/jaguar.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(
          Icons.visibility_rounded,
          size: 120,
          color: Color(0xFFFB8C00),
        ),
        bankOrder: ['see', 'jaguar', 'I', 'a'],
        correctSlotOrder: ['I', 'see', 'a', 'jaguar'],
        submitNextRoute: AppRoutes.quizAlphabetSet2_8,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet2_8,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 8,
        imageAssetPath: 'assets/icons/quiz/set1/jungle.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(
          Icons.park_rounded,
          size: 120,
          color: Color(0xFF2E7D32),
        ),
        bankOrder: ['big', 'is', 'jungle', 'The'],
        correctSlotOrder: ['The', 'jungle', 'is', 'big'],
        coinsReward: 60,
      ),
    ),
    // ------------------------------------------------------------------------
    // Alphabet Quiz Set 3 (K to O)
    // ------------------------------------------------------------------------
    GoRoute(
      path: AppRoutes.quizAlphabetSet3_1,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 1,
        questionText: 'What animal is this?',
        imageAssetPath: 'assets/icons/quiz/set3/whale.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.waves_rounded, size: 120, color: Color(0xFF1565C0)),
        options: ['Octopus', 'Killer Whale', 'Lobster', 'Manatee'],
        correctAnswerIndex: 1,
        submitNextRoute: AppRoutes.quizAlphabetSet3_2,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet3_2,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 2,
        imageAssetPath: 'assets/icons/quiz/set3/kelp.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(
          Icons.grass_rounded,
          size: 120,
          color: Color(0xFF43A047),
        ),
        instructionText: 'Drag the letters to spell the word',
        bankOrder: ['L', 'K', 'P', 'E'],
        correctSlotOrder: ['K', 'E', 'L', 'P'],
        submitNextRoute: AppRoutes.quizAlphabetSet3_3,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet3_3,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 3,
        questionText: 'What animal is this?',
        imageAssetPath: 'assets/icons/quiz/set3/lobster.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.bug_report_rounded, size: 120, color: Color(0xFFD32F2F)),
        options: ['Nemo', 'Orca', 'Lobster', 'Kelp'],
        correctAnswerIndex: 2,
        submitNextRoute: AppRoutes.quizAlphabetSet3_4,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet3_4,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 4,
        imageAssetPath: 'assets/icons/quiz/set3/lion.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(
          Icons.set_meal_rounded,
          size: 120,
          color: Color(0xFFE53935),
        ),
        instructionText: 'Drag the letters to spell the word',
        bankOrder: ['O', 'N', 'L', 'I'],
        correctSlotOrder: ['L', 'I', 'O', 'N'],
        submitNextRoute: AppRoutes.quizAlphabetSet3_5,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet3_5,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 5,
        questionText: 'What animal is this?',
        imageAssetPath: 'assets/icons/quiz/set3/manatee.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.water_rounded, size: 120, color: Color(0xFF78909C)),
        options: ['Kelp', 'Manatee', 'Lionfish', 'Octopus'],
        correctAnswerIndex: 1,
        submitNextRoute: AppRoutes.quizAlphabetSet3_6,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet3_6,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 6,
        imageAssetPath: 'assets/icons/quiz/set3/nemo.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(
          Icons.set_meal_rounded,
          size: 120,
          color: Color(0xFFFF9800),
        ),
        instructionText: 'Drag the letters to spell the word',
        bankOrder: ['E', 'O', 'N', 'M'],
        correctSlotOrder: ['N', 'E', 'M', 'O'],
        submitNextRoute: AppRoutes.quizAlphabetSet3_7,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet3_7,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 7,
        questionText: 'What animal is this?',
        imageAssetPath: 'assets/icons/quiz/set3/octopus.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.bubble_chart_rounded, size: 120, color: Color(0xFFE91E63)),
        options: ['Manatee', 'Killer Whale', 'Nemo', 'Octopus'],
        correctAnswerIndex: 3,
        submitNextRoute: AppRoutes.quizAlphabetSet3_8,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet3_8,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 8,
        imageAssetPath: 'assets/icons/quiz/set3/orca.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(
          Icons.waves_rounded,
          size: 120,
          color: Color(0xFF1565C0),
        ),
        instructionText: 'Drag the letters to spell the word',
        bankOrder: ['R', 'A', 'O', 'C'],
        correctSlotOrder: ['O', 'R', 'C', 'A'],
        coinsReward: 70,
      ),
    ),
    // ------------------------------------------------------------------------
    // Alphabet Quiz Set 4 (P to T Space)
    // ------------------------------------------------------------------------
    GoRoute(
      path: AppRoutes.quizAlphabetSet4_1,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 1,
        questionText: 'What is this?',
        imageAssetPath: 'assets/icons/quiz/set4/earth.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.public_rounded, size: 120, color: Color(0xFF4CAF50)),
        options: ['Star', 'Planet', 'Sun', 'Moon'],
        correctAnswerIndex: 1,
        submitNextRoute: AppRoutes.quizAlphabetSet4_2,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet4_2,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 2,
        imageAssetPath: 'assets/icons/quiz/set4/quasar.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.blur_on_rounded, size: 120, color: Color(0xFFE91E63)),
        statement: 'A quasar is very bright.',
        correctAnswerIndex: 0, // 0 = True, 1 = False
        submitNextRoute: AppRoutes.quizAlphabetSet4_3,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet4_3,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 3,
        imageAssetPath: 'assets/icons/quiz/set4/ring.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.camera_rounded, size: 120, color: Color(0xFFFFC107)),
        instructionText: 'Drag the letters to spell the word',
        bankOrder: ['N', 'I', 'G', 'R'],
        correctSlotOrder: ['R', 'I', 'N', 'G'],
        submitNextRoute: AppRoutes.quizAlphabetSet4_4,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet4_4,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 4,
        imageAssetPath: 'assets/icons/quiz/set4/sun.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.wb_sunny_rounded, size: 120, color: Color(0xFFFF9800)),
        statement: 'The sun is cold.',
        correctAnswerIndex: 1, // False
        submitNextRoute: AppRoutes.quizAlphabetSet4_5,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet4_5,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 5,
        questionText: 'What is this?',
        imageAssetPath: 'assets/icons/quiz/set4/spaceship.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.rocket_launch_rounded, size: 120, color: Color(0xFF9C27B0)),
        options: ['Planet', 'Telescope', 'Spaceship', 'Sun'],
        correctAnswerIndex: 2,
        submitNextRoute: AppRoutes.quizAlphabetSet4_6,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet4_6,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 6,
        imageAssetPath: 'assets/icons/quiz/set4/star.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.star_rounded, size: 120, color: Color(0xFFFFEB3B)),
        instructionText: 'Drag the letters to spell the word',
        bankOrder: ['A', 'R', 'S', 'T'],
        correctSlotOrder: ['S', 'T', 'A', 'R'],
        submitNextRoute: AppRoutes.quizAlphabetSet4_7,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet4_7,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 7,
        imageAssetPath: 'assets/icons/quiz/set4/telescope.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.center_focus_strong_rounded, size: 120, color: Color(0xFF607D8B)),
        statement: 'A telescope sees far.',
        correctAnswerIndex: 0, // True
        submitNextRoute: AppRoutes.quizAlphabetSet4_8,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet4_8,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 8,
        imageAssetPath: 'assets/icons/quiz/set4/suit.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.accessibility_new_rounded, size: 120, color: Color(0xFFFFFFFF)),
        instructionText: 'Drag the letters to spell the word',
        bankOrder: ['T', 'S', 'U', 'I'],
        correctSlotOrder: ['S', 'U', 'I', 'T'],
        coinsReward: 80,
      ),
    ),
    // ------------------------------------------------------------------------
    // Alphabet Quiz Set 5 (U to Z Magic)
    // ------------------------------------------------------------------------
    GoRoute(
      path: AppRoutes.quizAlphabetSet5_1,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 1,
        questionText: 'What is this?',
        imageAssetPath: 'assets/icons/quiz/set5/unicorn.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.cruelty_free_rounded, size: 120, color: Color(0xFFE91E63)),
        options: ['Dragon', 'Wizard', 'Unicorn', 'Yeti'],
        correctAnswerIndex: 2,
        submitNextRoute: AppRoutes.quizAlphabetSet5_2,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet5_2,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 2,
        imageAssetPath: 'assets/icons/quiz/set5/wand.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.auto_fix_high_rounded, size: 120, color: Color(0xFFFFC107)),
        instructionText: 'Drag the letters to spell the word',
        bankOrder: ['D', 'A', 'W', 'N'],
        correctSlotOrder: ['W', 'A', 'N', 'D'],
        submitNextRoute: AppRoutes.quizAlphabetSet5_3,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet5_3,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 3,
        questionText: 'What is this?',
        imageAssetPath: 'assets/icons/quiz/set5/wizard.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.face_retouching_natural_rounded, size: 120, color: Color(0xFF673AB7)),
        options: ['Vampire', 'Wizard', 'Zombie', 'Yeti'],
        correctAnswerIndex: 1,
        submitNextRoute: AppRoutes.quizAlphabetSet5_4,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet5_4,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 4,
        imageAssetPath: 'assets/icons/quiz/set5/x-ray.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.document_scanner_rounded, size: 120, color: Color(0xFF00BCD4)),
        statement: 'An X-ray shows your bones.',
        correctAnswerIndex: 0, // True
        submitNextRoute: AppRoutes.quizAlphabetSet5_5,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet5_5,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 5,
        imageAssetPath: 'assets/icons/quiz/set5/snow_yeti.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.ac_unit_rounded, size: 120, color: Color(0xFF2196F3)),
        instructionText: 'Drag the letters to spell the word',
        bankOrder: ['I', 'T', 'E', 'Y'],
        correctSlotOrder: ['Y', 'E', 'T', 'I'],
        submitNextRoute: AppRoutes.quizAlphabetSet5_6,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet5_6,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 6,
        questionText: 'What is this?',
        imageAssetPath: 'assets/icons/quiz/set5/zombie.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.personal_injury_rounded, size: 120, color: Color(0xFF4CAF50)),
        options: ['Zombie', 'Wizard', 'Vampire', 'Yeti'],
        correctAnswerIndex: 0,
        submitNextRoute: AppRoutes.quizAlphabetSet5_7,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAlphabetSet5_7,
      builder: (context, state) => const AlphabetQuizPuzzleRoundPage(
        questionNumber: 7,
        imageAssetPath: 'assets/icons/quiz/set5/maze.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.pattern_rounded, size: 120, color: Color(0xFFFF5722)),
        instructionText: 'Drag the letters to spell the word',
        bankOrder: ['E', 'Z', 'M', 'A'],
        correctSlotOrder: ['M', 'A', 'Z', 'E'],
        coinsReward: 70,
      ),
    ),
    // ------------------------------------------------------------------------
    // Colors Quiz Set 2
    // ------------------------------------------------------------------------
    GoRoute(
      path: AppRoutes.quizColorSet2_1,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 1,
        questionText: 'What color is this?',
        imageAssetPath: 'assets/icons/quiz/colors_set2/red.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.apple_rounded, size: 120, color: Color(0xFFF44336)),
        options: ['Blue', 'Red', 'Green', 'Yellow'],
        correctAnswerIndex: 1,
        submitNextRoute: AppRoutes.quizColorSet2_2,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizColorSet2_2,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 2,
        imageAssetPath: 'assets/icons/quiz/colors_set2/banana.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.lunch_dining_rounded, size: 120, color: Color(0xFFFFEB3B)),
        statement: 'A banana is yellow.',
        correctAnswerIndex: 0, // True
        submitNextRoute: AppRoutes.quizColorSet2_3,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizColorSet2_3,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 3,
        questionText: 'What color is this?',
        imageAssetPath: 'assets/icons/quiz/colors_set2/green_frog.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.pest_control_rounded, size: 120, color: Color(0xFF4CAF50)),
        options: ['Blue', 'Red', 'Green', 'Orange'],
        correctAnswerIndex: 2,
        submitNextRoute: AppRoutes.quizColorSet2_4,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizColorSet2_4,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 4,
        imageAssetPath: 'assets/icons/quiz/colors_set2/sky.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.cloud_rounded, size: 120, color: Color(0xFF03A9F4)),
        statement: 'The sky is green.',
        correctAnswerIndex: 1, // False
        submitNextRoute: AppRoutes.quizColorSet2_5,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizColorSet2_5,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 5,
        questionText: 'What color is this?',
        imageAssetPath: 'assets/icons/quiz/colors_set2/water.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.water_drop_rounded, size: 120, color: Color(0xFF2196F3)),
        options: ['Pink', 'Blue', 'Black', 'Yellow'],
        correctAnswerIndex: 1,
        submitNextRoute: AppRoutes.quizColorSet2_6,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizColorSet2_6,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 6,
        imageAssetPath: 'assets/icons/quiz/colors_set2/flamingo.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.cruelty_free_rounded, size: 120, color: Color(0xFFE91E63)),
        statement: 'A flamingo is pink.',
        correctAnswerIndex: 0, // True
        submitNextRoute: AppRoutes.quizColorSet2_7,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizColorSet2_7,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 7,
        questionText: 'What color is this?',
        imageAssetPath: 'assets/icons/quiz/colors_set2/orange.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.food_bank_rounded, size: 120, color: Color(0xFFFF9800)),
        options: ['Orange', 'Red', 'Blue', 'Green'],
        correctAnswerIndex: 0,
        submitNextRoute: AppRoutes.quizColorSet2_8,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizColorSet2_8,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 8,
        imageAssetPath: 'assets/icons/quiz/colors_set2/snow.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.ac_unit_rounded, size: 120, color: Color(0xFFFFFFFF)),
        statement: 'Snow is black.',
        correctAnswerIndex: 1, // False
        coinsReward: 80,
      ),
    ),
    // ------------------------------------------------------------------------
    // Numbers Quiz Set 2
    // ------------------------------------------------------------------------
    GoRoute(
      path: AppRoutes.quizNumbersSet2_1,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 1,
        questionText: 'How many apples?',
        imageAssetPath: 'assets/icons/quiz/numbers_set2/apple.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.apple_rounded, size: 120, color: Color(0xFFF44336)),
        options: ['1', '2', '3', '4'],
        correctAnswerIndex: 2,
        submitNextRoute: AppRoutes.quizNumbersSet2_2,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizNumbersSet2_2,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 2,
        imageAssetPath: 'assets/icons/quiz/numbers_set2/cat.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.pets_rounded, size: 120, color: Color(0xFF795548)),
        statement: 'There is 1 cat here.',
        correctAnswerIndex: 0, // True
        submitNextRoute: AppRoutes.quizNumbersSet2_3,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizNumbersSet2_3,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 3,
        imageAssetPath: 'assets/icons/quiz/numbers_set2/car.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.directions_car_rounded, size: 120, color: Color(0xFF2196F3)),
        statement: 'There are 4 cars here.',
        correctAnswerIndex: 1, // False
        submitNextRoute: AppRoutes.quizNumbersSet2_4,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizNumbersSet2_4,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 4,
        questionText: 'How many dogs?',
        imageAssetPath: 'assets/icons/quiz/numbers_set2/dogs.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.pets_rounded, size: 120, color: Color(0xFF795548)),
        options: ['1', '2', '3', '4'],
        correctAnswerIndex: 2,
        submitNextRoute: AppRoutes.quizNumbersSet2_5,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizNumbersSet2_5,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 5,
        imageAssetPath: 'assets/icons/quiz/numbers_set2/stars.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.star_rounded, size: 120, color: Color(0xFFFFEB3B)),
        statement: 'There are 5 stars here.',
        correctAnswerIndex: 0, // True
        submitNextRoute: AppRoutes.quizNumbersSet2_6,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizNumbersSet2_6,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 6,
        questionText: 'How many trees?',
        imageAssetPath: 'assets/icons/quiz/numbers_set2/tree.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.park_rounded, size: 120, color: Color(0xFF4CAF50)),
        options: ['1', '2', '3', '4'],
        correctAnswerIndex: 0,
        coinsReward: 60,
      ),
    ),
    // ------------------------------------------------------------------------
    // Animals Quiz Set 2
    // ------------------------------------------------------------------------
    GoRoute(
      path: AppRoutes.quizAnimalsSet2_1,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 1,
        questionText: 'What animal is this?',
        imageAssetPath: 'assets/icons/quiz/animals_set2/tiger.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.pets_rounded, size: 120, color: Color(0xFFFF9800)),
        options: ['Lion', 'Tiger', 'Bear', 'Cat'],
        correctAnswerIndex: 1,
        submitNextRoute: AppRoutes.quizAnimalsSet2_2,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAnimalsSet2_2,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 2,
        imageAssetPath: 'assets/icons/quiz/animals_set2/cow.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.agriculture_rounded, size: 120, color: Color(0xFF795548)),
        statement: 'A cow says moo.',
        correctAnswerIndex: 0, // True
        submitNextRoute: AppRoutes.quizAnimalsSet2_3,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAnimalsSet2_3,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 3,
        questionText: 'What animal is this?',
        imageAssetPath: 'assets/icons/quiz/animals_set2/elephant.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.cruelty_free_rounded, size: 120, color: Color(0xFF9E9E9E)),
        options: ['Elephant', 'Rhino', 'Hippo', 'Giraffe'],
        correctAnswerIndex: 0,
        submitNextRoute: AppRoutes.quizAnimalsSet2_4,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAnimalsSet2_4,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 4,
        imageAssetPath: 'assets/icons/quiz/animals_set2/dog.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.pets_rounded, size: 120, color: Color(0xFF795548)),
        statement: 'A dog has two legs.',
        correctAnswerIndex: 1, // False
        submitNextRoute: AppRoutes.quizAnimalsSet2_5,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAnimalsSet2_5,
      builder: (context, state) => const AlphabetQuizMultipleChoiceRoundPage(
        questionNumber: 5,
        questionText: 'What animal is this?',
        imageAssetPath: 'assets/icons/quiz/animals_set2/monkey.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.face_retouching_natural_rounded, size: 120, color: Color(0xFF795548)),
        options: ['Ape', 'Gorilla', 'Monkey', 'Chimp'],
        correctAnswerIndex: 2,
        submitNextRoute: AppRoutes.quizAnimalsSet2_6,
      ),
    ),
    GoRoute(
      path: AppRoutes.quizAnimalsSet2_6,
      builder: (context, state) => const AlphabetQuizTrueFalseRoundPage(
        questionNumber: 6,
        imageAssetPath: 'assets/icons/quiz/animals_set2/bird_feather.png',
        imageWidth: 200,
        imageHeight: 200,
        fallback: Icon(Icons.flutter_dash_rounded, size: 120, color: Color(0xFF4CAF50)),
        statement: 'A bird has feathers.',
        correctAnswerIndex: 0, // True
        coinsReward: 70,
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
