import 'package:gyan_jyoti/shared/widgets/app_asset_image.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart' show Share;

import '../../../../core/constants/app_assets.dart';
import '../../../../core/navigation/go_to_app_home.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/png_share_files.dart';
import '../../../../core/utils/breakpoints.dart';
import 'widgets/color_activity_brush_row.dart';
import 'widgets/immediate_pan_gesture_recognizer.dart';
import '../../../../shared/widgets/quiz_header.dart';
import '../../../../shared/widgets/crescent_border_card.dart';

/// Hot-air balloon coloring — `color_ballon.webp`, upright, full white card;
/// same interaction as [ColorTheTreePage].
class ColorTheBigBalloonPage extends StatefulWidget {
  const ColorTheBigBalloonPage({super.key});

  @override
  State<ColorTheBigBalloonPage> createState() => _ColorTheBigBalloonPageState();
}

class _PaletteEntry {
  const _PaletteEntry({required this.label, required this.color});
  final String label;
  final Color color;
}

class _StrokeData {
  _StrokeData({
    required this.color,
    required this.points,
    required this.strokeWidth,
  });
  final Color color;
  final List<Offset> points;
  final double strokeWidth;

  _StrokeData copy() => _StrokeData(
        color: color,
        points: List<Offset>.from(points),
        strokeWidth: strokeWidth,
      );
}

class _ColorTheBigBalloonPageState extends State<ColorTheBigBalloonPage> {
  /// Screen background outside the activity card (white margins).
  static const Color _pageBg = Color(0xFFFFFFFF);
  /// Main activity card — cream; Done sits on page background.
  static const Color _cardBg = Color(0xFFFBFBE4);
  static const Color _brownSwatch = Color(0xFFBE8876);
  static const Color _coralSwatch = Color(0xFFFD7260);
  static const Color _yellowSwatch = Color(0xFFFADD5F);
  static const Color _skySwatch = Color(0xFF8BD6FF);
  static const Color _greenSwatch = Color(0xFFA7DC5F);

  static const List<_PaletteEntry> _palette = <_PaletteEntry>[
    _PaletteEntry(label: 'Brown', color: _brownSwatch),
    _PaletteEntry(label: 'Coral', color: _coralSwatch),
    _PaletteEntry(label: 'Yellow', color: _yellowSwatch),
    _PaletteEntry(label: 'Blue', color: _skySwatch),
    _PaletteEntry(label: 'Green', color: _greenSwatch),
  ];

  late Color _selectedColor;
  int _brushSizeIndex = 1;
  final List<_StrokeData> _strokes = <_StrokeData>[];
  List<Offset>? _currentStroke;
  ui.Image? _maskImage;

  /// Snapshots after each committed stroke; [0] is the empty canvas.
  final List<List<_StrokeData>> _strokeHistory = <List<_StrokeData>>[[]];
  int _historyIndex = 0;

  final GlobalKey _canvasExportKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _selectedColor = _coralSwatch;
    _loadMaskImage();
  }

  Future<void> _loadMaskImage() async {
    try {
      final data = await DefaultAssetBundle.of(context).load(AppAssets.artsCraftColorBigLineArt);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      if (mounted) {
        setState(() {
          _maskImage = frame.image;
        });
      }
    } catch (e) {
      debugPrint("Error loading mask image: $e");
    }
  }

  @override
  void dispose() {
    _maskImage?.dispose();
    super.dispose();
  }

  void _selectColor(Color c) => setState(() => _selectedColor = c);

  void _selectBrushSize(int index) {
    if (index < 0 || index >= kColorActivityBrushStrokeWidths.length) return;
    setState(() => _brushSizeIndex = index);
  }

  double get _activeBrushWidth =>
      kColorActivityBrushStrokeWidths[_brushSizeIndex];

  List<_StrokeData> _cloneStrokes(List<_StrokeData> src) =>
      src.map((s) => s.copy()).toList();

  void _undo() {
    if (_historyIndex <= 0) return;
    setState(() {
      _currentStroke = null;
      _historyIndex--;
      _strokes
        ..clear()
        ..addAll(_strokeHistory[_historyIndex].map((s) => s.copy()));
    });
  }

  void _redo() {
    if (_historyIndex >= _strokeHistory.length - 1) return;
    setState(() {
      _currentStroke = null;
      _historyIndex++;
      _strokes
        ..clear()
        ..addAll(_strokeHistory[_historyIndex].map((s) => s.copy()));
    });
  }

  Future<void> _shareCanvas() async {
    if (!mounted) return;
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final boundary =
        _canvasExportKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Picture is not ready yet. Try again.')),
      );
      return;
    }
    ui.Image? image;
    try {
      final dpr = MediaQuery.devicePixelRatioOf(context);
      image = await boundary.toImage(pixelRatio: dpr);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Could not create image. Try again.')),
        );
        return;
      }
      final Uint8List bytes = byteData.buffer.asUint8List();
      final files = await buildPngShareFiles(bytes, 'color_the_big_balloon.png');
      await Share.shareXFiles(files);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not share the picture. Try again.')),
      );
    } finally {
      image?.dispose();
    }
  }

  BoxDecoration get _cardDecoration => BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08), width: 1),
      );

  /// Tall drawing area; whole cream card scrolls as one (instructions + image).
  double _canvasSectionHeight(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    return (h * 0.54).clamp(300.0, 580.0);
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
              title: 'Color the Big Balloon',
              onBack: () => goToAppHome(context),
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Breakpoints.contentMaxWidth(context) ?? double.infinity,
                  ),
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
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 16, 16, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Let's color the Big Balloon!",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.headlineLarge.copyWith(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Choose a color below and fill in the balloon',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.titleSmall.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textPrimary,
                                        height: 1.35,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Wrap(
                                          alignment: WrapAlignment.center,
                                          spacing: 8,
                                          runSpacing: 10,
                                          children: [
                                            for (var i = 0; i < _palette.length; i++)
                                              _SmallRoundSwatch(
                                                entry: _palette[i],
                                                selected:
                                                    _palette[i].color == _selectedColor,
                                                onTap: () =>
                                                    _selectColor(_palette[i].color),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        ColorActivityBrushSizeRow(
                                          selectedIndex: _brushSizeIndex,
                                          onSelect: _selectBrushSize,
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          height: 100,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 4),
                                              child: _HorizontalToolRail(
                                                onDownload: _shareCanvas,
                                                onRedo: _historyIndex <
                                                        _strokeHistory.length - 1
                                                    ? _redo
                                                    : null,
                                                onUndo:
                                                    _historyIndex > 0 ? _undo : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
                                child: SizedBox(
                                  height: _canvasSectionHeight(context),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: Colors.black.withValues(alpha: 0.06),
                                        width: 1,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(23),
                                      child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        final w = constraints.maxWidth;
                                        final h = constraints.maxHeight;
                                        return RepaintBoundary(
                                          key: _canvasExportKey,
                                          child: SizedBox(
                                            width: w,
                                            height: h,
                                            child: _maskImage == null
                                                ? AppAssetImage(
  assetPath: AppAssets.artsCraftColorBigLineArt,
  width: w,
  height: h,
  fit: BoxFit.contain,
  fallback: Icon(
                                                      Icons.air_rounded,
                                                      size: 72,
                                                      color: Colors.grey.shade400,
                                                    ),
)
                                                : RawGestureDetector(
                                                    gestures: <Type, GestureRecognizerFactory>{
                                                      ImmediatePanGestureRecognizer:
                                                          GestureRecognizerFactoryWithHandlers<ImmediatePanGestureRecognizer>(
                                                        () => ImmediatePanGestureRecognizer(),
                                                        (ImmediatePanGestureRecognizer instance) {
                                                          instance
                                                            ..onStart = (d) {
                                                              setState(() {
                                                                _currentStroke = [d.localPosition];
                                                              });
                                                            }
                                                            ..onUpdate = (d) {
                                                              setState(() {
                                                                _currentStroke = [
                                                                  ...?_currentStroke,
                                                                  d.localPosition,
                                                                ];
                                                              });
                                                            }
                                                            ..onEnd = (_) {
                                                              setState(() {
                                                                if (_currentStroke != null &&
                                                                    _currentStroke!.isNotEmpty) {
                                                                  _strokeHistory.removeRange(
                                                                    _historyIndex + 1,
                                                                    _strokeHistory.length,
                                                                  );
                                                                  _strokes.add(
                                                                    _StrokeData(
                                                                      color: _selectedColor,
                                                                      points: List<Offset>.from(
                                                                        _currentStroke!,
                                                                      ),
                                                                      strokeWidth: _activeBrushWidth,
                                                                    ),
                                                                  );
                                                                  _strokeHistory.add(
                                                                    _cloneStrokes(_strokes),
                                                                  );
                                                                  _historyIndex =
                                                                      _strokeHistory.length - 1;
                                                                }
                                                                _currentStroke = null;
                                                              });
                                                            };
                                                        },
                                                      ),
                                                    },
                                                    child: CustomPaint(
                                                      size: Size(w, h),
                                                      painter: _BigBalloonPaintOverlay(
                                                        strokes: _strokes,
                                                        currentStroke: _currentStroke,
                                                        currentColor: _selectedColor,
                                                        currentStrokeWidth: _activeBrushWidth,
                                                        maskImage: _maskImage,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ColorTheBigBalloonDoneButton(
                      onPressed: () => context.pop(true),
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
    );
  }
}

class _SmallRoundSwatch extends StatelessWidget {
  const _SmallRoundSwatch({
    required this.entry,
    required this.selected,
    required this.onTap,
  });

  final _PaletteEntry entry;
  final bool selected;
  final VoidCallback onTap;

  static const double _diameter = 40;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: _diameter,
              height: _diameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: entry.color,
                border: Border.all(
                  color: selected ? AppColors.textPrimary : Colors.black26,
                  width: selected ? 2.5 : 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              entry.label,
              style: AppTextStyles.labelSmall.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HorizontalToolRail extends StatelessWidget {
  const _HorizontalToolRail({
    required this.onDownload,
    required this.onRedo,
    required this.onUndo,
  });

  final VoidCallback onDownload;
  final VoidCallback? onRedo;
  final VoidCallback? onUndo;

  @override
  Widget build(BuildContext context) {
    // Order: Undo → Redo → Download (Download is always last).
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _HorizontalToolButton(
            icon: Icons.undo_rounded,
            label: 'Undo',
            onTap: onUndo,
          ),
          const SizedBox(width: 8),
          _HorizontalToolButton(
            icon: Icons.redo_rounded,
            label: 'Redo',
            onTap: onRedo,
          ),
          const SizedBox(width: 8),
          _HorizontalToolButton(
            icon: Icons.sim_card_download_rounded,
            label: 'Download',
            onTap: onDownload,
          ),
        ],
      ),
    );
  }
}

/// Matches [DrawTreePage] `_DoneButton` (GestureDetector, height 72).
class _ColorTheBigBalloonDoneButton extends StatelessWidget {
  const _ColorTheBigBalloonDoneButton({required this.onPressed});

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

class _HorizontalToolButton extends StatelessWidget {
  const _HorizontalToolButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final color = enabled ? AppColors.textPrimary : Colors.black26;
    final textStyle = AppTextStyles.titleSmall.copyWith(
      fontWeight: FontWeight.w600,
      color: color,
      fontSize: 10,
    );

    return Semantics(
      label: label,
      button: true,
      enabled: enabled,
      onTap: enabled ? onTap : null,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (onTap != null) onTap!();
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 52, minHeight: 64),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Opacity(
              opacity: enabled ? 1 : 0.45,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 26, color: color),
                  const SizedBox(height: 2),
                  Text(label, style: textStyle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BigBalloonPaintOverlay extends CustomPainter {
  _BigBalloonPaintOverlay({
    required this.strokes,
    required this.currentStroke,
    required this.currentColor,
    required this.currentStrokeWidth,
    required this.maskImage,
  });

  final List<_StrokeData> strokes;
  final List<Offset>? currentStroke;
  final Color currentColor;
  final double currentStrokeWidth;
  final ui.Image? maskImage;

  @override
  void paint(Canvas canvas, Size size) {
    if (maskImage == null) return;

    final sizeMask = Size(maskImage!.width.toDouble(), maskImage!.height.toDouble());
    final sizes = applyBoxFit(BoxFit.contain, sizeMask, size);
    final Rect inputSubrect = Alignment.center.inscribe(sizes.source, Offset.zero & sizeMask);
    final Rect outputSubrect = Alignment.center.inscribe(sizes.destination, Offset.zero & size);

    // 1. Save a layer to isolate masking/blending
    canvas.saveLayer(Offset.zero & size, Paint());

    // 2. Draw the mask image
    canvas.drawImageRect(maskImage!, inputSubrect, outputSubrect, Paint());

    // 3. Draw the strokes using BlendMode.srcATop to clip them to the mask's opaque region
    for (final s in strokes) {
      _drawStroke(canvas, s.color, s.points, s.strokeWidth, blendMode: BlendMode.srcATop);
    }
    if (currentStroke != null && currentStroke!.isNotEmpty) {
      _drawStroke(canvas, currentColor, currentStroke!, currentStrokeWidth, blendMode: BlendMode.srcATop);
    }

    // 4. Draw the outlines on top using BlendMode.darken to keep them black without erasing transparent bg
    canvas.drawImageRect(
      maskImage!,
      inputSubrect,
      outputSubrect,
      Paint()..blendMode = BlendMode.darken,
    );

    // 5. Restore the canvas layer
    canvas.restore();
  }

  void _drawStroke(
    Canvas canvas,
    Color color,
    List<Offset> pts,
    double strokeWidth, {
    required BlendMode blendMode,
  }) {
    if (pts.isEmpty) return;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..blendMode = blendMode;

    if (pts.length == 1) {
      final r = (strokeWidth * 0.5).clamp(4.0, 16.0);
      canvas.drawCircle(pts.first, r, Paint()..color = color..blendMode = blendMode);
      return;
    }
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 1; i < pts.length; i++) {
      path.lineTo(pts[i].dx, pts[i].dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BigBalloonPaintOverlay oldDelegate) {
    return true;
  }
}
