import 'package:flutter/gestures.dart';

/// A custom PanGestureRecognizer that eagerly claims victory in the gesture arena
/// immediately on pointer down, preventing parent scroll views from scrolling.
class ImmediatePanGestureRecognizer extends PanGestureRecognizer {
  @override
  void addAllowedPointer(PointerDownEvent event) {
    super.addAllowedPointer(event);
    resolve(GestureDisposition.accepted);
  }
}
