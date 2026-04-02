import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/routes/injection/injection.dart';
import '../../../shared/fluid/fluid_config.dart';
import '../../../shared/theme/app_colors.dart';
import '../../theme/app_dim.dart';


class PrimaryTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? label;
  final InputBorder? border;
  final ValueChanged<String?>? onChanged;
  final bool? filled;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final bool showError;
  final int? maxLines;
  final bool readOnly;
  final bool autoFocus;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const PrimaryTextFormField({
    required this.controller,
    this.label,
    super.key,
    this.keyboardType,
    this.hintText,
    this.border,
    this.filled,
    this.fillColor,
    this.validator,
    this.showError = true,
    this.autoFocus = true,
    this.maxLines,
    this.readOnly = false,
    this.onChanged,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final fluid = locator<FluidConfig>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (label != null) ...[
          Text(label!, style: TextStyle(fontSize: fluid.fluid(AppDim.d14, AppDim.d16))),
          const Gap(6.28),
        ],

        TextFormField(
          autofocus: autoFocus,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          readOnly: readOnly,
          onChanged: onChanged,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(
              14,
              9,
              14,
              9,
            ),
            fillColor: fillColor,
            filled: filled,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.hintText,
              fontWeight: FontWeight.w400,
            ).copyWith(fontSize: fluid.fluid(AppDim.d14, AppDim.d16)),
            hintFadeDuration: const Duration(milliseconds: 350),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,

            border:
                border ??
                const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(color: AppColors.primaryBorder, width: 0.5),
                ),
            enabledBorder:
                border ??
                const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(color: AppColors.primaryBorder, width: 0.5),
                ),
            focusedBorder:
                border ??
                const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(color: AppColors.primaryBorder, width: 0.5),
                ),
            errorBorder:
                border ??
                const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(color: AppColors.errorRed, width: 0.5),
                ),
            errorStyle: showError ? null : const TextStyle(height: 0),
          ),
        ),
      ],
    );
  }
}
