// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../../../../shared/extensions/build_context_extension.dart';
// import '../../../../../../shared/theme/app_colors.dart';
// import '../../../../../../shared/theme/app_dim.dart';
// import '../../../../../../shared/theme/app_svgs.dart';
// import '../../../../../core/enums/animated_button_state_enum.dart';
// import '../../../../../core/injection/injection.dart';
// import '../../../../../shared/fluid/fluid_box.dart';
// import '../../../../../shared/fluid/fluid_text.dart';
// import '../../../button/primary_button.dart';
// import '../application/request_location_permission_cubit.dart';

// class LocationPermissionModal extends StatelessWidget {
//   const LocationPermissionModal({super.key});

//   @override
//   Widget build(BuildContext context) => BlocProvider(
//     create: (context) => locator<RequestLocationPermissionCubit>(),
//     child: Container(
//       padding: EdgeInsets.symmetric(vertical: 24, horizontal: context.devicePadding),
//       child: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Header with icon and close button
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Trash icon with background
//                 FluidBox(
//                   minHeight: 46,
//                   maxHeight: 52,
//                   minWidth: 46,
//                   maxWidth: 52,
//                   child: SvgPicture.asset(AppSvgs.locationPermission, height: double.infinity, width: double.infinity),
//                 ),
//                 const Spacer(),
//                 // Close button
//                 IconButton(
//                   onPressed: () => context.router.maybePop(),
//                   icon: const Icon(Icons.close, size: AppDim.d24),
//                   color: AppColors.grey,
//                   splashRadius: 20,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Title
//             Align(
//               alignment: Alignment.centerLeft,
//               child: FluidText(
//                 'Turn On Your LocatioAn to See Deals',
//                 maxFontSize: 26,
//                 minFontSize: 24,
//                 style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textBlack, height: 1.3),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Description
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: FluidText(
//                 'Get accurate nearby offers instantly. Manage location settings anytime.',
//                 minFontSize: 16,
//                 maxFontSize: 18,
//                 style: TextStyle(color: AppColors.grey, height: 1.5),
//               ),
//             ),
//             const SizedBox(height: 32),

//             // Buttons
//             Row(
//               children: [
//                 // Cancel button
//                 Expanded(
//                   child: PrimaryButton(
//                     onTap: () => context.router.maybePop(),
//                     text: 'Cancel',
//                     foreGroundColor: AppColors.grey,
//                     backgroundColor: AppColors.white,
//                     border: Border.all(color: AppColors.primaryBorder),
//                   ),
//                 ),
//                 const SizedBox(width: 16),

//                 // Delete button
//                 Expanded(
//                   child: BlocConsumer<RequestLocationPermissionCubit, AnimatedButtonStateEnum>(
//                     listener: (context, state) {
//                       if (state == AnimatedButtonStateEnum.success) {
//                         context.router.maybePop();
//                       }
//                     },
//                     builder: (context, state) => PrimaryButton(
//                       animatedButtonState: state,
//                       onTap: () => context.read<RequestLocationPermissionCubit>().getPermission(),
//                       text: 'Allow', onPressed: () {  },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
