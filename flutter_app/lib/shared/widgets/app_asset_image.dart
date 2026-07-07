import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssetImage extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget fallback;
  final ColorFilter? colorFilter;

  const AppAssetImage({
    super.key,
    required this.assetPath,
    required this.fallback,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.colorFilter,
  });

  static final RegExp _embeddedPngPattern = RegExp(
    r'data:image/png;base64,([^"]+)',
    dotAll: true,
  );

  static Future<Uint8List?> _extractEmbeddedPng(String assetPath) async {
    if (!assetPath.toLowerCase().endsWith('.svg')) {
      return null;
    }

    final rawSvg = await rootBundle.loadString(assetPath);
    final match = _embeddedPngPattern.firstMatch(rawSvg);
    if (match == null) {
      return null;
    }

    return base64Decode(match.group(1)!);
  }

  @override
  Widget build(BuildContext context) {
    final resolvedPath = assetPath;

    if (!resolvedPath.toLowerCase().endsWith('.svg')) {
      return Image.asset(
        resolvedPath,
        width: width,
        height: height,
        fit: fit,
        filterQuality: FilterQuality.medium,
        errorBuilder: (_, __, ___) => fallback,
      );
    }

    return FutureBuilder<Uint8List?>(
      future: _extractEmbeddedPng(resolvedPath),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            width: width,
            height: height,
            fit: fit,
            filterQuality: FilterQuality.medium,
            errorBuilder: (_, __, ___) => fallback,
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return SvgPicture.asset(
            resolvedPath,
            width: width,
            height: height,
            fit: fit,
            colorFilter: colorFilter,
            placeholderBuilder: (_) => fallback,
          );
        }

        return fallback;
      },
    );
  }
}
