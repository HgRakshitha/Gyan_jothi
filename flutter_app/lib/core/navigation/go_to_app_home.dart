import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';

/// Top header back: leave the current feature and show the main tab home.
void goToAppHome(BuildContext context) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go(AppRoutes.home);
  }
}

/// Art & Craft chapter screens (Creative Drawing, Make a Scene, Fold & Create, etc.).
void goToArtCraftHome(BuildContext context) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go(AppRoutes.artCraftHome);
  }
}

/// Header back when the screen may be an overlay (e.g. [MaterialPageRoute]
/// from the dashboard). Pops that route if possible; otherwise [goToAppHome].
void popOrGoToAppHome(BuildContext context) {
  final navigator = Navigator.of(context);
  if (navigator.canPop()) {
    navigator.pop();
  } else {
    goToAppHome(context);
  }
}
