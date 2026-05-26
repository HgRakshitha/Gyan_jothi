import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/navigation/go_to_app_home.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../shared/widgets/quiz_header.dart';
import '../../../../shared/widgets/crescent_border_card.dart';
import 'widgets/immediate_pan_gesture_recognizer.dart';

class _PlacedSticker {
  _PlacedSticker({
    required this.id,
    required this.assetPath,
    required this.position,
  });

  final int id;
  final String assetPath;
  Offset position;
  double scale = 1.0;
  bool isFlipped = false;
}

/// Make a Birthday Party — scene builder (same layout as [BuildAFarmPage]).
class MakeABirthdayPartyPage extends StatefulWidget {
  const MakeABirthdayPartyPage({super.key});

  @override
  State<MakeABirthdayPartyPage> createState() => _MakeABirthdayPartyPageState();
}

class _MakeABirthdayPartyPageState extends State<MakeABirthdayPartyPage> {

  static const Color _pageBg = Color(0xFFFFFFFF);
  static const Color _cardBg = Color(0xFFFBFBE4);

  static const double _kCanvasW = 584;
  static const double _kCanvasH = 333;
  static const double _kStickerLogical = 64;
  static const double _kAddStickerCenterX =
      (_kCanvasW - _kStickerLogical) / 2;
  static const double _kAddStickerCenterY =
      (_kCanvasH - _kStickerLogical) / 2;

  static const List<({String asset, String label})> _stickerDefs =
      <({String asset, String label})>[
    (asset: AppAssets.artsCraftMakeSceneStickerCake, label: 'Cake'),
    (asset: AppAssets.artsCraftMakeSceneStickerBalloons, label: 'Balloons'),
    (asset: AppAssets.artsCraftMakeSceneStickerGifts, label: 'Gifts'),
    (asset: AppAssets.artsCraftMakeSceneStickerFriends, label: 'Friends'),
  ];

  final List<_PlacedSticker> _stickers = <_PlacedSticker>[];
  int _nextStickerId = 0;
  int? _selectedStickerId;

  void _addSticker(String assetPath) {
    setState(() {
      final newId = _nextStickerId++;
      _stickers.add(
        _PlacedSticker(
          id: newId,
          assetPath: assetPath,
          position: const Offset(_kAddStickerCenterX, _kAddStickerCenterY),
        ),
      );
      _selectedStickerId = newId;
    });
  }

  void _clampSticker(_PlacedSticker s) {
    final size = _kStickerLogical * s.scale;
    s.position = Offset(
      s.position.dx.clamp(0.0, _kCanvasW - size),
      s.position.dy.clamp(0.0, _kCanvasH - size),
    );
  }

  void _deleteSelectedSticker() {
    if (_selectedStickerId == null) return;
    setState(() {
      _stickers.removeWhere((st) => st.id == _selectedStickerId);
      _selectedStickerId = null;
    });
  }

  void _flipSelectedSticker() {
    if (_selectedStickerId == null) return;
    setState(() {
      final s = _stickers.firstWhere((st) => st.id == _selectedStickerId);
      s.isFlipped = !s.isFlipped;
    });
  }

  void _scaleSelectedSticker(double factor) {
    if (_selectedStickerId == null) return;
    setState(() {
      final s = _stickers.firstWhere((st) => st.id == _selectedStickerId);
      s.scale = (s.scale + factor).clamp(0.5, 2.0);
      _clampSticker(s);
    });
  }

  BoxDecoration get _cardDecoration => BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08), width: 1),
      );

  Widget _buildPlacedSticker(_PlacedSticker sticker, double s) {
    final bool isSelected = sticker.id == _selectedStickerId;
    final double sz = _kStickerLogical * sticker.scale * s;
    final double widgetSize = sz + 48;
    final double leftOffset = (sticker.position.dx * s) - 24;
    final double topOffset = (sticker.position.dy * s) - 24;

    return Positioned(
      left: leftOffset,
      top: topOffset,
      width: widgetSize,
      height: widgetSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 24,
            top: 24,
            width: sz,
            height: sz,
            child: RawGestureDetector(
              gestures: {
                ImmediatePanGestureRecognizer: GestureRecognizerFactoryWithHandlers<ImmediatePanGestureRecognizer>(
                  () => ImmediatePanGestureRecognizer(),
                  (ImmediatePanGestureRecognizer instance) {
                    instance.onStart = (_) {
                      setState(() {
                        _selectedStickerId = sticker.id;
                        _stickers.remove(sticker);
                        _stickers.add(sticker);
                      });
                    };
                    instance.onUpdate = (d) {
                      setState(() {
                        sticker.position += d.delta / s;
                        _clampSticker(sticker);
                      });
                    };
                  },
                ),
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  if (isSelected)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepPurpleAccent,
                            width: 2.5,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.diagonal3Values(
                          sticker.isFlipped ? -1.0 : 1.0,
                          1.0,
                          1.0,
                        ),
                        child: Image.asset(
                          sticker.assetPath,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.image_rounded,
                            size: 32,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSelected) ...[
            Positioned(
              left: 24 - 16,
              top: 24 - 16,
              width: 32,
              height: 32,
              child: GestureDetector(
                onTap: _deleteSelectedSticker,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.delete_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24 + sz - 16,
              top: 24 - 16,
              width: 32,
              height: 32,
              child: GestureDetector(
                onTap: _flipSelectedSticker,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.swap_horiz_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24 - 16,
              top: 24 + sz - 16,
              width: 32,
              height: 32,
              child: GestureDetector(
                onTap: () => _scaleSelectedSticker(-0.25),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.remove_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24 + sz - 16,
              top: 24 + sz - 16,
              width: 32,
              height: 32,
              child: GestureDetector(
                onTap: () => _scaleSelectedSticker(0.25),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: _pageBg,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuizHeader(
              title: 'Make a Birthday Party',
              onBack: () => goToAppHome(context),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 12 + bottomInset),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: _cardDecoration,
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Column(
                                children: [
                                  Text(
                                    'Build Your Birthday Party',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.headlineLarge.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Drag and decorate your party scene.',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.titleSmall.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0; i < _stickerDefs.length; i++) ...[
                                    if (i > 0) const SizedBox(width: 8),
                                    Expanded(
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: _BirthdayStickerChip(
                                          assetPath: _stickerDefs[i].asset,
                                          label: _stickerDefs[i].label,
                                          onTap: () => _addSticker(_stickerDefs[i].asset),
                                        ),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final maxW = constraints.maxWidth;
                                    final maxH = constraints.maxHeight;
                                    
                                    double canvasW = maxW;
                                    double canvasH = canvasW * (_kCanvasH / _kCanvasW);
                                    
                                    if (canvasH > maxH) {
                                      canvasH = maxH;
                                      canvasW = canvasH * (_kCanvasW / _kCanvasH);
                                    }
                                    
                                    final s = canvasW / _kCanvasW;
                                    const r = 24.0;

                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Center(
                                        child: Container(
                                          width: canvasW,
                                          height: canvasH,
                                          decoration: BoxDecoration(
                                            color: _cardBg,
                                            borderRadius: BorderRadius.circular(r),
                                            border: Border.all(
                                              color: Colors.black.withValues(alpha: 0.08),
                                              width: 1.5,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.04),
                                                blurRadius: 10,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              setState(() {
                                                _selectedStickerId = null;
                                              });
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(r),
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Positioned.fill(
                                                    child: Image.asset(
                                                      AppAssets.artsCraftMakeSceneDreamBirthday,
                                                      fit: BoxFit.cover,
                                                      filterQuality: FilterQuality.high,
                                                      errorBuilder: (_, __, ___) =>
                                                          ColoredBox(
                                                        color: Colors.grey.shade200,
                                                        child: Icon(
                                                          Icons.celebration_rounded,
                                                          size: 64,
                                                          color: Colors.grey.shade500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  for (final sticker in _stickers)
                                                    _buildPlacedSticker(sticker, s),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _MakeABirthdayPartyDoneButton(
                      onPressed: () => context.pop(true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BirthdayStickerChip extends StatelessWidget {
  const _BirthdayStickerChip({
    required this.assetPath,
    required this.label,
    required this.onTap,
  });

  final String assetPath;
  final String label;
  final VoidCallback onTap;

  static const double _imageSize = 36;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.labelSmall.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 11,
      color: AppColors.textPrimary,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.08),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _imageSize,
                height: _imageSize,
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.layers, size: 28),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: textStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MakeABirthdayPartyDoneButton extends StatelessWidget {
  const _MakeABirthdayPartyDoneButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CrescentBorderCard(
        width: double.infinity,
        height: 72,
        padding: EdgeInsets.zero,
        borderWidth: 3.0,
        innerColor: const Color(0x29DBF226),
        borderGradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(225, 221, 30, 0.2),
            Color(0xFFDBF226),
            Color.fromRGBO(225, 221, 30, 0.2),
          ],
          stops: [0.0002, 0.5029, 0.9998],
        ),
        child: Center(
          child: Text(
            'Done',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
