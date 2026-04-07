import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dim.dart';

abstract class AppTypography {
  /// Size 16
  static const double sMedium = 16;

  /// FontWeight 600
  static const FontWeight _wSemiBold = FontWeight.w600;

  static const TextStyle bodyMedium = TextStyle(
    color: AppColors.greyText,
    fontSize: AppDim.d14,
    fontWeight: FontWeight.w500,
    height: 1.57,
    letterSpacing: 0.5,
  );

  static const TextStyle buttonSemiBold = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: _wSemiBold,
    height: 1.57,
  );
}
