import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../shared/snackbar_alerts/snack_alert.dart';
import '../../../../shared/theme/app_images.dart';
import '../application/splash_cubit.dart';
import '../application/splash_state.dart';

@RoutePage()
class SplashScreen extends StatelessWidget implements AutoRouteWrapper {
  const SplashScreen({super.key});
  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (context) => SplashCubit()..initialize(),
        child: this,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {
            state.when(
              onLoading: () {},
              navigateToOnboarding: () {
                context.router.replace(const OnboardingRoute());
              },
              navigateToLogin: () {
                context.router.replace(const LoginRoute());
              },
              navigateToHome: () {
                context.router.replace(const HomeRoute());
              },
              error: (error) {
                SnackBarAlert().showToast(message: error, isWarning: true);
              },
            );
          },
          builder: (context, state) => state.maybeMap(
              orElse: () => const Text('ERROR'),

              onLoading: (value) => Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      AppImages.splashBottom,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.splashImage, height: 60),
                      ],
                    ),
                  ),
                ],
              ),

              error: (_) => const Center(child: Text('ERROR OCCURED')),
            ),
        ),
      );
  
}
