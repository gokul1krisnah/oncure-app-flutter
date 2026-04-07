import 'package:flutter/widgets.dart';

import '../../../shared/fluid/fluid_config.dart';

/// A responsive [Text] widget that scales its font size based on the screen width.
///
/// The `FluidText` widget uses the `Fluid.fluid` utility to calculate a font size
/// that smoothly transitions between a `minFontSize` and a `maxFontSize`.
/// This is ideal for creating typography that looks great on any screen, from
/// small phones to large desktops, without abrupt changes at breakpoints.
class FluidText extends StatelessWidget {
  /// The text to display.
  final String data;

  /// The base style to apply to the text.
  ///
  /// The `fontSize` from this style will be overridden by the fluid calculation.
  final TextStyle? style;

  /// The minimum font size to use when the screen is narrow.
  final double minFontSize;

  /// The maximum font size to use when the screen is wide.
  final double maxFontSize;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// The locale used to select region-specific glyphs.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// An optional maximum number of lines for the text to span.
  final int? maxLines;

  /// An alternative semantics label for this text.
  final String? semanticsLabel;

  /// The different ways of measuring the width of one or more lines of text.
  final TextWidthBasis? textWidthBasis;

  /// Defines how to apply custom line heights to the first and last lines of a paragraph.
  final TextHeightBehavior? textHeightBehavior;

  /// Creates a fluid text widget.
  ///
  /// The [data] parameter is the text to be displayed.
  /// The [minFontSize] and [maxFontSize] parameters are required to define the
  /// scaling range for the font size.
  const FluidText(
    this.data, {
    required this.minFontSize,
    required this.maxFontSize,
    super.key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the responsive font size using the Fluid utility.
    final fontSize = Fluid.fluid(minFontSize, maxFontSize);

    // Build a standard [Text] widget, applying the calculated fluid font size.
    return Text(
      data,
      style: (style ?? const TextStyle()).copyWith(fontSize: fontSize),
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
