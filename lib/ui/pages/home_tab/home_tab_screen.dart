// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';

// import '../../../core/routes/app_router.gr.dart';
// import '../../widgets/bottom_nav/stacked_bottom_navigation.dart';

// @RoutePage()
// class HomeTabScreen extends StatelessWidget {
//   const HomeTabScreen({super.key});

//   @override
//   Widget build(BuildContext context) => AutoTabsRouter(
//     routes: const [HomeRoute(), HomeRoute(), HomeRoute()],
//     builder: (context, child) {
//       final tabsRouter = context.tabsRouter;

//       bool canPop() => tabsRouter.activeIndex == BottomTabEnum.home.index;

//       void onPopInvokedWithResult(bool didPop, _) {
//         final current = tabsRouter.activeIndex;
//         if (current == BottomTabEnum.home.index) {
//           context.router.maybePop();
//           return;
//         }
//         // if (current == BottomTabEnum.stores.index && context.read<SearchCubit>().isFromSearch) {
//         //   context.read<SearchCubit>().popScreen();
//         //   return;
//         // }
//         tabsRouter.setActiveIndex(BottomTabEnum.home.index);
//       }

//       return Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: PopScope(
//           canPop: canPop(),
//           onPopInvokedWithResult: onPopInvokedWithResult,
//           child: Stack(
//             children: [
//               child,
//               const Positioned(left: 0, right: 0, bottom: 0, child: StackBottomNavigation()),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
