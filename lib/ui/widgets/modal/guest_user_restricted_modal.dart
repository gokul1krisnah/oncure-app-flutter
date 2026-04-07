// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../core/routes/app_router.gr.dart';
// import '../../../shared/extensions/build_context_extension.dart';
// import '../../../shared/theme/app_colors.dart';
// import '../../../shared/theme/app_dim.dart';
// import '../../../shared/theme/app_svgs.dart';
// import '../buttons/primary_button.dart';
// import '../fluid/fluid_box.dart';
// import '../fluid/fluid_text.dart';

// class GuestUserRestrictedModal extends StatelessWidget {
//   const GuestUserRestrictedModal({super.key});

//   @override
//   Widget build(BuildContext context) => Container(
//     padding: EdgeInsets.symmetric(vertical: 24, horizontal: context.devicePadding),
//     child: SafeArea(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Header with icon and close button
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Trash icon with background
//               FluidBox(
//                 minHeight: 46,
//                 maxHeight: 52,
//                 minWidth: 46,
//                 maxWidth: 52,
//                 child: SvgPicture.asset(AppSvgs.guestUserWarning, height: double.infinity, width: double.infinity),
//               ),
//               const Spacer(),
//               // Close button
//               IconButton(
//                 onPressed: () => context.router.maybePop(),
//                 icon: const Icon(Icons.close, size: AppDim.d24),
//                 color: AppColors.grey,
//                 splashRadius: 20,
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),

//           // Title
//           const Align(
//             alignment: Alignment.centerLeft,
//             child: FluidText(
//               'Access Restricted',
//               maxFontSize: 26,
//               minFontSize: 24,
//               style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textBlack, height: 1.3),
//             ),
//           ),
//           const SizedBox(height: 16),

//           // Description
//           const Align(
//             alignment: Alignment.centerLeft,
//             child: FluidText(
//               'You need to sign in to the app to access the feature.',
//               minFontSize: 16,
//               maxFontSize: 18,
//               style: TextStyle(color: AppColors.grey, height: 1.5),
//             ),
//           ),
//           const SizedBox(height: 32),

//           // Buttons
//           Row(
//             children: [
//               // Cancel button
//               Expanded(
//                 child: PrimaryButton(
//                   onTap: () => context.router.maybePop(),
//                   text: 'Cancel',
//                   foreGroundColor: AppColors.grey,
//                   backgroundColor: AppColors.white,
//                   border: Border.all(color: AppColors.primaryBorder),
//                 ),
//               ),
//               const SizedBox(width: 16),

//               // Delete button
//               Expanded(
//                 child: PrimaryButton(onTap: () => context.router.replaceAll([const LoginRoute()]), text: 'Sign In'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
