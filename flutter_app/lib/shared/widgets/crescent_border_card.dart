import 'package:flutter/material.dart';

/// A reusable widget that provides a 2-layer side-border (crescent style) 
/// similar to the Announcement tabs.
class CrescentBorderCard extends StatelessWidget {
  const CrescentBorderCard({
    super.key,
    required this.child,
    this.innerColor = const Color(0xFFFBFBE4), // Default tab inside color
    this.borderColor = const Color(0xFFF7F6C4),
    this.borderGradient,
    this.borderRadius = 36.5,
    this.borderWidth = 5.0,
    this.padding = const EdgeInsets.all(16.0),
    this.width,
    this.height,
    this.boxShadow,
  });

  final Widget child;
  final Color innerColor;
  final Color borderColor;
  final Gradient? borderGradient;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: borderWidth),
      decoration: BoxDecoration(
        color: borderGradient == null ? borderColor : null,
        gradient: borderGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow,
      ),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: innerColor,
          borderRadius: BorderRadius.circular(borderRadius - borderWidth),
        ),
        child: child,
      ),
    );
  }
}
