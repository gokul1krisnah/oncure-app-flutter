import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),

    AutoRoute(
      page: HomeTabRoute.page,
      path: '/', // This is the root path for the tab bar.
      children: [
        AutoRoute(path: 'home', page: HomeRoute.page, initial: true),
        // AutoRoute(path: 'profile-menu', page: ProfileMenuRoute.page),
      ],
    ),

    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: VerifyRoute.page),
    AutoRoute(page: CreateAccountRoute.page),
    AutoRoute(page: HomeRoute.page),
  ];
}

/// A route guard that checks if a user is authenticated before allowing navigation.
///
/// If the user is not authenticated, it prevents navigation and shows a modal
/// prompting them to log in.
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // Check if the user is logged in by accessing the SettingsRepository.
    // if (locator<SettingsRepository>().settings.hasLogged) {
    //   // If authenticated, allow the navigation to proceed.
    //   resolver.next(true);
    // } else {
    //   // If not authenticated, prevent navigation.
    //   // First, check if there is a valid context to show the modal.
    //   if (router.navigatorKey.currentContext == null) {
    //     locator<SnackBarAlert>().showToast(message: 'Something Went wrong', isWarning: true);
    //     return; // Abort if no context is available.
    //   }
    //   // Show a modal dialog restricting access for guest users.
    //   CustomModal.showBottomModal(
    //     isScrollControlled: true,
    //     useSafeArea: true,
    //     context: router.navigatorKey.currentContext!,
    //     builder: (context) => const GuestUserRestrictedModal(),
    //   );
    //   // Do not call resolver.next(), effectively blocking the navigation.
    // }
  }
}
