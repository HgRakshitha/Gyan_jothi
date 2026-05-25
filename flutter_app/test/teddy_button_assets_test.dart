import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gyan_jyoti/core/constants/app_assets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Teddy button scene PNGs load and decode', () async {
    final paths = <String>[
      AppAssets.storyTeddyButtonOne,
      AppAssets.storyTeddyButtonTwo,
      AppAssets.storyTeddyButtonThree,
      AppAssets.storyTeddyButtonFour,
      AppAssets.storyTeddyButtonFive,
    ];
    for (final p in paths) {
      final data = await rootBundle.load(p);
      expect(data.lengthInBytes, greaterThan(1024), reason: p);
      final codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
      );
      final frame = await codec.getNextFrame();
      expect(frame.image.width, greaterThan(0), reason: p);
      frame.image.dispose();
    }
  });
}
