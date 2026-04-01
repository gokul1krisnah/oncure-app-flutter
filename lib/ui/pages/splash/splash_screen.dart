import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_my_onco/core/routes/app_router.gr.dart';
import 'package:plan_my_onco/shared/theme/app_images.dart';
import 'package:plan_my_onco/ui/pages/splash/application/splash_cubit.dart';
import 'package:plan_my_onco/ui/pages/splash/application/splash_state.dart';

@RoutePage()
class SplashScreen extends StatelessWidget implements AutoRouteWrapper {
  const SplashScreen({super.key});


  @override
  Widget wrappedRoute(BuildContext context) {
   return BlocProvider(create: (context) => SplashCubit()..initialize(),child: this,);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<SplashCubit, SplashState>(
          listenWhen: (previous, current) => current is NavigateToOnboarding,
          listener: (context, state) {
            if (state is NavigateToOnboarding) {
              context.router.push(OnboardingRoute());
            }
          },
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => Text('ERROR'),

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

              error: (_) => Center(child: Text("ERROR OCCURED")),
            );
          },
        ),
      
    );
  }
  
}
