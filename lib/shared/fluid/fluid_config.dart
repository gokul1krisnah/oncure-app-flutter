// This file defines a responsive scaling utility for creating "fluid" layouts
// that adapt smoothly to different screen sizes.
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../../core/routes/injection/injection.dart';




/// A configuration class for the fluid scaling system.
///
/// This singleton class is responsible for holding the screen context and calculating
/// values that scale proportionally between a minimum and maximum screen width.
/// It mimics the behavior of the CSS `clamp()` function to create fluid typography,
/// spacing, and layouts.
@lazySingleton
class FluidConfig {
  /// The minimum screen width at which scaling starts. Below this width, values will be clamped to their minimum.
  static const double minWidth = 320;

  /// The maximum screen width at which scaling stops. Above this width, values will be clamped to their maximum.
  static const double maxWidth = 1440;

  late BuildContext _context;

  /// Initializes the [FluidConfig] with the root [BuildContext].
  ///
  /// This must be called once, typically in the builder of the `MaterialApp`,
  /// so that the utility can access the screen dimensions.
  void init(BuildContext context) {
    _context = context;
  }

  /// The current width of the screen.
  double get screenWidth => MediaQuery.of(_context).size.width;

  /// Calculates a fluid value that scales linearly between a `min` and `max` value
  /// based on the current screen width, constrained by [minWidth] and [maxWidth].
  ///
  /// For screen widths at or below [minWidth], this returns `min`.
  /// For screen widths at or above [maxWidth], this returns `max`.
  /// For screen widths in between, it returns a calculated value on the linear scale.
  ///
  /// Example: `fluid(12, 24)` might return 12 on a small phone, 24 on a desktop,
  /// and 18 on a tablet.
  double fluid(double min, double max) {
    final width = screenWidth;

    // Clamp to the minimum value if the screen is too narrow.
    if (width <= minWidth) return min;
    // Clamp to the maximum value if the screen is too wide.
    if (width >= maxWidth) return max;

    // Perform linear interpolation for screen widths between the min and max thresholds.
    return min + (max - min) * ((width - minWidth) / (maxWidth - minWidth));
  }
}

/// A static facade for easy access to the fluid scaling utility.
///
/// This class provides a simple, global way to initialize and use the [FluidConfig]
/// singleton without needing to interact with the service locator directly in the UI code.
abstract class Fluid {
  /// Initializes the fluid scaling system with a [BuildContext].
  ///
  /// This should be called once at the root of the widget tree, for example,
  /// in the `builder` of your `MaterialApp`.
  static void init(BuildContext context) => locator<FluidConfig>().init(context);

  /// Calculates a fluid value that scales between `min` and `max`.
  ///
  /// This is a convenient static accessor for [FluidConfig.fluid].
  /// Example: `Fluid.fluid(16, 22)` for responsive font sizes.
  static double fluid(double min, double max) => locator<FluidConfig>().fluid(min, max);
}
