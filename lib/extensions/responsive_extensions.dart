import 'dart:math';
import 'package:flutter/material.dart';

class DimensionsHelper {
  final BuildContext context;

  DimensionsHelper(this.context);

  // Size of AppBar Height
  double get appBarHeight => kToolbarHeight;

  // Size of Status Bar Height
  double get statusBarHeight => MediaQuery.of(context).padding.top;

  // Size of Screen Height
  double get screenHeight => MediaQuery.of(context).size.height;

  // Size of Screen Width
  double get screenWidth => MediaQuery.of(context).size.width;

  // Text scale factor
  double textScaleFactor({double maxTextScaleFactor = 2.0}) {
    final width = screenWidth;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

extension Dimensions on BuildContext {
  DimensionsHelper get dimensions => DimensionsHelper(this);
}
