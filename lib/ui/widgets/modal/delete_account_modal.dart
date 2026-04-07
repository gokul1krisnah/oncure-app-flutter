// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gap/gap.dart';

// import '../../../core/injection/injection.dart';
// import '../../../shared/extensions/build_context_extension.dart';
// import '../../../shared/fluid/fluid_box.dart';
// import '../../../shared/fluid/fluid_text.dart';
// import '../../../shared/theme/app_colors.dart';
// import '../../../shared/theme/app_dim.dart';
// import '../../../shared/theme/app_svgs.dart';
// import '../button/primary_button.dart';


// class DeleteAccountDialog extends StatelessWidget implements AutoRouteWrapper {
//   const DeleteAccountDialog({super.key});

//   @override
//   Widget wrappedRoute(BuildContext context) =>
//       BlocProvider(create: (context) => locator<DeleteAccountCubit>(), child: this);
//   @override
//   Widget build(BuildContext context) {
//     final points = [
//       'You can only request to delete your account',
//       'The request will be reviewed and approved by the admin before deletion.',
//       'Once approved, all your data (including wishlist, saved offers, etc.) will be permanently deleted.',
//       'This action cannot be undone.',
//     ];

//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 24, horizontal: context.devicePadding),
//         child: SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Header with icon and close button
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Trash icon with background
//                   FluidBox(
//                     maxHeight: 52,
//                     maxWidth: 52,
//                     minHeight: 46,
//                     minWidth: 46,
//                     child: SvgPicture.asset(AppSvgs.deleteAccountRed, height: 48, width: 48),
//                   ),
//                   const Spacer(),
//                   // Close button
//                   IconButton(
//                     onPressed: () => context.router.maybePop(),
//                     icon: const Icon(Icons.close, size: AppDim.d24),
//                     color: AppColors.grey,
//                     splashRadius: 20,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               // Title
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: FluidText(
//                   'Before you proceed, please note:',
//                   style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textBlack, height: 1.5),
//                   minFontSize: AppDim.d18,
//                   maxFontSize: AppDim.d16,
//                 ),
//               ),
//               const Gap(AppDim.d10),

//               // Description
//               ...List.generate(
//                 points.length,
//                 (index) => Padding(
//                   padding: const EdgeInsets.only(bottom: AppDim.d10),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(top: 8, right: 12, left: 8),
//                         width: 6,
//                         height: 6,
//                         decoration: const BoxDecoration(color: AppColors.grey, shape: BoxShape.circle),
//                       ),
//                       Expanded(
//                         child: FluidText(
//                           maxFontSize: AppDim.d16,
//                           minFontSize: AppDim.d14,
//                           points[index],
//                           style: const TextStyle(color: AppColors.grey),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const Gap(AppDim.d32),

//               // Buttons
//               Row(
//                 children: [
//                   // Cancel button
//                   Expanded(
//                     child: PrimaryButton(
//                       onTap: () => context.router.maybePop(),
//                       text: 'Cancel',
//                       foreGroundColor: AppColors.grey,
//                       backgroundColor: AppColors.white,
//                       border: const Border.fromBorderSide(BorderSide(color: AppColors.primaryBorder)),
//                     ),
//                   ),
//                   Expanded(
//                     child: PrimaryButton(onTap: () => context.router.maybePop(), text: 'Delete'),
//                   ),
//                   const SizedBox(width: 16),

//                   // Delete button
//                   // Expanded(
//                   //   child: BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
//                   //     listener: (context, state) {
//                   //       if (state is DeleteAccountStateSuccess) {
//                   //         locator<SnackBarAlert>().showToast(message: 'You request has been send successfully.');
//                   //         context.router.maybePop();
//                   //       }
//                   //     },
//                   //     builder: (context, state) => ModalButton(
//                   //       buttonStateEnum: state.buttonState,
//                   //       // buttonStateEnum: AnimatedButtonStateEnum.loading,
//                   //       onTap: () => context.read<DeleteAccountCubit>().deleteAccount(),
//                   //       buttonText: 'Proceed',
//                   //       buttonFgColor: AppColors.white,
//                   //       buttonBgColor: Colors.red.shade600,
//                   //       borderColor: Colors.red.shade600,
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
