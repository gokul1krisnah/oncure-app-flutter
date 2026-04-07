// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../core/data/repositories/settings_repository.dart';
// import '../../../core/injection/injection.dart';
// import '../../../shared/extensions/build_context_extension.dart';
// import '../../../shared/fluid/fluid_box.dart';
// import '../../../shared/fluid/fluid_config.dart';
// import '../../../shared/fluid/fluid_text.dart';
// import '../../../shared/theme/app_colors.dart';
// import '../../../shared/theme/app_dim.dart';
// import '../../../shared/theme/app_svgs.dart';
// import '../modal/custom_modal.dart';
// import '../modal/guest_user_restricted_modal.dart';


// enum BottomTabEnum {
//   home(icon: AppSvgs.home, name: 'Home', selectedIcon: AppSvgs.homeSelected),
//   stores(icon: AppSvgs.store, name: 'Fiind', selectedIcon: AppSvgs.storeSelected),
//   menu(icon: AppSvgs.profile, name: 'Profile', selectedIcon: AppSvgs.profileSelected);

//   const BottomTabEnum({required this.icon, required this.name, required this.selectedIcon});

//   final String icon;
//   final String selectedIcon;
//   final String name;

//   double get width {
//     final fluid = locator<FluidConfig>();
//     return switch (this) {
//       home => fluid.fluid(24, 26),
//       stores => fluid.fluid(24, 24),
//       menu => fluid.fluid(24, 24),
//     };
//   }

//   double get height {
//     final fluid = locator<FluidConfig>();
//     return switch (this) {
//       home => fluid.fluid(24, 26),
//       stores => fluid.fluid(24, 24),
//       menu => fluid.fluid(24, 24),
//     };
//   }
// }

// class StackBottomNavigation extends StatelessWidget {
//   const StackBottomNavigation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final fluidPadding = locator<FluidConfig>().fluid(8, 16);

//     return DecoratedBox(
//       decoration: const BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.navBarShadow, // Shadow color
//             spreadRadius: 0, // How wide the shadow spreads
//             blurRadius: 60, // Softness
//             offset: Offset(0, -20), // Negative Y for top shadow
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.only(bottom: context.deviceSafePadding.bottom, left: fluidPadding, right: fluidPadding),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: List.generate(
//             4,
//             (index) => Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(AppDim.d10),
//                 child: _BuildNavItem(bottomTabEnum: BottomTabEnum.values[index]),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _BuildNavItem extends StatefulWidget {
//   final BottomTabEnum bottomTabEnum;

//   const _BuildNavItem({required this.bottomTabEnum});

//   @override
//   State<_BuildNavItem> createState() => _BuildNavItemState();
// }

// class _BuildNavItemState extends State<_BuildNavItem> {
//   late TabsRouter _tabsRouter;
//   final ValueNotifier<bool> _isSelect = ValueNotifier(false);

//   @override
//   void initState() {
//     super.initState();
//     _tabsRouter = context.tabsRouter;
//     _updateSelection();
//     _tabsRouter.addListener(_updateSelection);
//   }

//   void _updateSelection() {
//     _isSelect.value =
//         _tabsRouter.activeIndex == widget.bottomTabEnum.index ||
//         (_tabsRouter.activeIndex == BottomTabEnum.stores.index && widget.bottomTabEnum == BottomTabEnum.stores);
//   }

//   @override
//   void dispose() {
//     _tabsRouter.removeListener(_updateSelection);
//     _isSelect.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final fluid = locator<FluidConfig>();
//     return GestureDetector(
//       onTap: () => _onTap(context),
//       behavior: HitTestBehavior.opaque,
//       child: AnimatedContainer(
//         height: fluid.fluid(52, 56),
//         duration: const Duration(milliseconds: 200),
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               FluidBox.square(
//                 minSize: 28,
//                 maxSize: 32,
//                 child: ValueListenableBuilder(
//                   valueListenable: _isSelect,
//                   builder: (context, value, child) => SvgPicture.asset(
//                     !value ? widget.bottomTabEnum.icon : widget.bottomTabEnum.selectedIcon,
//                     height: double.infinity,
//                     width: double.infinity,
//                   ),
//                 ),
//               ),
//               ValueListenableBuilder(
//                 valueListenable: _isSelect,
//                 builder: (context, value, child) => Flexible(
//                   child: FluidText(
//                     widget.bottomTabEnum.name,
//                     minFontSize: AppDim.d12,
//                     maxFontSize: AppDim.d14,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(color: value ? AppColors.primary : AppColors.tabText),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _onTap(BuildContext context) async {
//     final tabIndex = context.tabsRouter.activeIndex;
//     if (widget.bottomTabEnum == BottomTabEnum.home && !locator<SettingsRepository>().settings.hasLogged) {
//       await CustomModal.showBottomModal(
//         isScrollControlled: true,
//         useSafeArea: true,
//         context: context,
//         builder: (context) => const GuestUserRestrictedModal(),
//       );
//       return;
//     }
//     // context.read<SearchCubit>().resetFilter(false);

//     if (tabIndex != widget.bottomTabEnum.index) {
//       context.tabsRouter.setActiveIndex(widget.bottomTabEnum.index);
//       return;
//     }
//   }
// }
