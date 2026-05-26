import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/navigation/go_to_app_home.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/breakpoints.dart';
import '../../../core/utils/search_filter.dart';
import '../../../shared/widgets/app_asset_image.dart';
import '../../../shared/widgets/quiz_header.dart';
import '../../../shared/widgets/search_bar.dart';
import '../../../shared/widgets/search_empty_state.dart';
import 'quiz_sets_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String _query = '';

  static final _quizzes = <_QuizCardData>[
    const _QuizCardData(
      category: 'English',
      title: 'Alphabet Quiz',
      backgroundColor: Color(0xFFE9B6E7),
      imagePath: AppAssets.quizAlphabet,
      fallbackIcon: Icons.abc_rounded,
      navigateTo: AppRoutes.quizSets,
      setsArgs: QuizSetsPageArgs(
        title: 'Alphabet Quiz Sets',
        targetRoutes: [
          AppRoutes.quizAlphabet,
          AppRoutes.quizAlphabetSet2_1,
          AppRoutes.quizAlphabetSet3_1,
          AppRoutes.quizAlphabetSet4_1,
          AppRoutes.quizAlphabetSet5_1
        ],
        setQuestionCounts: [8, 8, 8, 8, 8],
        setCoins: [50, 60, 70, 80, 100],
        setNames: ['A to E Safari', 'F to J Jungle', 'K to O Ocean', 'P to T Space', 'U to Z Magic'],
        setEmojis: ['🐶', '🐱', '🦊', '🦁', '🐰'],
      ),
    ),
    const _QuizCardData(
      category: 'Art/ Visual Skills',
      title: 'Color Quiz',
      backgroundColor: Color(0xFFBDD6F0),
      imagePath: AppAssets.quizColors,
      fallbackIcon: Icons.palette_rounded,
      navigateTo: AppRoutes.quizSets,
      setsArgs: QuizSetsPageArgs(
        title: 'Color Quiz Sets',
        targetRoutes: [AppRoutes.quizColor, AppRoutes.quizColorSet2_1],
        setQuestionCounts: [11, 8],
        setCoins: [50, 80],
        setNames: ['Primary Colors', 'Mixed Colors'],
        setEmojis: ['🐶', '🐱'],
      ),
    ),
    const _QuizCardData(
      category: 'Math',
      title: 'Numbers Quiz',
      backgroundColor: Color(0xFFEFC0CF),
      imagePath: AppAssets.quizNumbers,
      fallbackIcon: Icons.calculate_rounded,
      navigateTo: AppRoutes.quizSets,
      setsArgs: QuizSetsPageArgs(
        title: 'Numbers Quiz Sets',
        targetRoutes: [AppRoutes.quizNumbers, AppRoutes.quizNumbersSet2_1],
        setQuestionCounts: [9, 6],
        setCoins: [50, 60],
        setNames: ['Counting 1 to 5', 'Fun Counting'],
        setEmojis: ['🐶', '🐱'],
      ),
    ),
    const _QuizCardData(
      category: 'General Knowledge',
      title: 'Animals Quiz',
      backgroundColor: Color(0xFFF0D7D9),
      imagePath: AppAssets.quizAnimals,
      fallbackIcon: Icons.pets_rounded,
      navigateTo: AppRoutes.quizSets,
      setsArgs: QuizSetsPageArgs(
        title: 'Animals Quiz Sets',
        targetRoutes: [AppRoutes.quizAnimals, AppRoutes.quizAnimalsSet2_1],
        setQuestionCounts: [9, 6],
        setCoins: [50, 70],
        setNames: ['Farm Animals', 'Mixed Animals'],
        setEmojis: ['🐶', '🐱'],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final maxContentW = Breakpoints.contentMaxWidth(context);
    final padH = Breakpoints.horizontalPadding(context);
    final padB = Breakpoints.scrollBottomPadding(context);

    final filtered = _quizzes
        .where(
          (q) => matchesSearchQuery(
            _query,
            [
              q.category,
              q.title,
            ],
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuizHeader(
                title: 'Quiz',
                onBack: () => popOrGoToAppHome(context),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(padH, 20, padH, padB),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxContentW ?? double.infinity,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSearchBar(
                            hint: 'Search Quiz',
                            onChanged: (v) => setState(() => _query = v),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Choose a Quiz',
                            style: AppTextStyles.titleMedium.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (filtered.isEmpty && _query.trim().isNotEmpty)
                            const SearchEmptyState()
                          else
                            ...List.generate(
                              filtered.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      index == filtered.length - 1 ? 0 : 18,
                                ),
                                child: _QuizCard(data: filtered[index]),
                              ),
                            ),
                      ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuizCard extends StatelessWidget {
  final _QuizCardData data;

  const _QuizCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final card = Container(
      height: 146,
      padding: const EdgeInsets.fromLTRB(18, 16, 14, 14),
      decoration: BoxDecoration(
        color: data.backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.category,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.black87,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.9),
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          '${data.setsArgs?.targetRoutes.length ?? 0} Sets',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.black87,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3CD),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xFFFFE69C),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const AppAssetImage(assetPath: AppAssets.iconCoin, width: 14, height: 14, fallback: SizedBox.shrink()),
                            const SizedBox(width: 4),
                            Text(
                              '+${data.setsArgs?.setCoins.fold<int>(0, (a, b) => a + b) ?? 0} Coins',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: const Color(0xFFB98A00),
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 128,
            child: Align(
              alignment: Alignment.centerRight,
              child: AppAssetImage(
                assetPath: data.imagePath,
                width: 128,
                height: 128,
                fallback: Icon(
                  data.fallbackIcon,
                  size: 74,
                  color: Colors.black.withValues(alpha: 0.42),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    if (data.navigateTo != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            if (data.setsArgs != null) {
              context.push(data.navigateTo!, extra: data.setsArgs);
            } else {
              context.push(data.navigateTo!);
            }
          },
          child: card,
        ),
      );
    }
    return card;
  }
}

class _RewardDots extends StatelessWidget {
  const _RewardDots();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _RewardCoin(),
        SizedBox(width: 2),
        _RewardCoin(),
        SizedBox(width: 2),
        _RewardCoin(),
      ],
    );
  }
}

class _RewardCoin extends StatelessWidget {
  const _RewardCoin();

  @override
  Widget build(BuildContext context) {
    return const AppAssetImage(
      assetPath: AppAssets.iconCoin,
      width: 14,
      height: 14,
      fallback: Icon(
        Icons.monetization_on_rounded,
        size: 14,
        color: Color(0xFFF6B300),
      ),
    );
  }
}

class _QuizCardData {
  final String category;
  final String title;
  final Color backgroundColor;
  final String imagePath;
  final IconData fallbackIcon;
  final String? navigateTo;
  final QuizSetsPageArgs? setsArgs;

  const _QuizCardData({
    required this.category,
    required this.title,
    required this.backgroundColor,
    required this.imagePath,
    required this.fallbackIcon,
    this.navigateTo,
    this.setsArgs,
  });
}
