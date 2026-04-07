// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';

// import '../../../shared/extensions/build_context_extension.dart';
// import '../../../shared/fluid/fluid_box.dart';
// import '../../../shared/theme/app_colors.dart';
// import '../../../shared/theme/app_dim.dart';
// import '../../../shared/theme/app_typography.dart';
// import '../button/primary_button.dart';


// abstract class CustomModal {
//   static Future<T?> showBottomModal<T>({
//     required BuildContext context,
//     required Widget Function(BuildContext context) builder,
//     bool isScrollControlled = false,
//     BoxConstraints? constraints,
//     bool isDismissible = true,
//     bool useSafeArea = false,
//   }) => showModalBottomSheet(
//     useSafeArea: useSafeArea,
//     context: context,
//     isScrollControlled: isScrollControlled,
//     isDismissible: isDismissible,
//     constraints: constraints,
//     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
//     backgroundColor: AppColors.white,
//     useRootNavigator: true,
//     showDragHandle: false,
//     builder: (context) => Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Gap(AppDim.d12),
//         const DecoratedBox(
//           decoration: BoxDecoration(
//             color: AppColors.primaryBorder,
//             borderRadius: BorderRadius.all(Radius.circular(AppDim.d2)),
//           ),
//           child: FluidBox(maxHeight: AppDim.d4, minHeight: AppDim.d4, minWidth: 50, maxWidth: 60),
//         ),
//         Flexible(child: builder(context)),
//       ],
//     ),
//   );

//   static Future<void> showDefaultModal({
//     required BuildContext context,
//     required String modalTitle,
//     required String modalBody,
//     required AsyncCallback? cancelTap,
//     required AsyncCallback? doneTap,
//     bool isScrollControlled = true,
//     BoxConstraints? constraints,
//   }) => showBottomModal(
//     context: context,
//     builder: (context) => Padding(
//       padding: EdgeInsets.only(bottom: context.safeBottomStrict),
//       child: DecoratedBox(
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(context.devicePadding),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(modalTitle, style: AppTypography.bodyMedium),
//               const Gap(8),
//               ConstrainedBox(
//                 constraints: const BoxConstraints(maxHeight: 200, minHeight: 100),
//                 child: Center(
//                   child: Text(modalBody, textAlign: TextAlign.center, style: AppTypography.bodyMedium),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Gap(8),
//                     Expanded(
//                       child: PrimaryButton(text: 'Cancel', onTap: () => cancelTap?.call(), onPressed: () {  },),
//                     ),
//                     const Gap(8),
//                     Expanded(
//                       child: PrimaryButton(text: 'Done', onTap: () => doneTap?.call(), onPressed: () {  },),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );

//   static Future<void> showCustomBottomModal({
//     required BuildContext context,
//     required Widget Function(BuildContext context) builder,
//     bool isScrollControlled = false,
//     BoxConstraints? constraints,
//   }) => showModalBottomSheet(
//     context: context,
//     isScrollControlled: isScrollControlled,
//     constraints: constraints,
//     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
//     backgroundColor: AppColors.white,
//     useRootNavigator: true,
//     builder: builder,
//     showDragHandle: false,
//   );
// }
