// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../../../core/enums/animated_button_state_enum.dart';
// import '../../../../../core/injection/injection.dart';
// import '../../../../../shared/extensions/build_context_extension.dart';
// import '../../../../../shared/theme/app_colors.dart';
// import '../../../../../shared/theme/app_dim.dart';
// import '../../../../../shared/theme/app_svgs.dart';
// import '../../../buttons/primary_button.dart';
// import '../../../fluid/fluid_box.dart';
// import '../../../fluid/fluid_text.dart';
// import '../application/request_notification_permission.dart';

// class NotificationPermissionModal extends StatelessWidget implements AutoRouteWrapper {
//   const NotificationPermissionModal({super.key});

//   @override
//   Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
//     providers: [BlocProvider.value(value: locator<RequestNotificationPermission>())],
//     child: this,
//   );

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
//                 maxWidth: 52,
//                 minWidth: 46,
//                 maxHeight: 52,
//                 minHeight: 46,
//                 child: SvgPicture.asset(AppSvgs.notificationUpdate, height: double.infinity, width: double.infinity),
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
//               'Get Updates',
//               minFontSize: 24,
//               maxFontSize: 26,
//               style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textBlack, height: 1.3),
//             ),
//           ),
//           const SizedBox(height: 16),

//           // Description
//           const Align(
//             alignment: Alignment.centerLeft,
//             child: FluidText(
//               'Allow finder to send you notifications for new offers & alerts.',
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
//                 child: BlocConsumer<RequestNotificationPermission, AnimatedButtonStateEnum>(
//                   listener: (context, state) =>
//                       state == AnimatedButtonStateEnum.success ? context.router.maybePop() : null,
//                   builder: (context, state) => PrimaryButton(
//                     onTap: () => context.read<RequestNotificationPermission>().requestPermission(),
//                     animatedButtonState: state,
//                     text: 'Allow',
//                     foreGroundColor: AppColors.white,
//                     backgroundColor: AppColors.secondary,
//                     border: Border.all(color: AppColors.secondary),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
