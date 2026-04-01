import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:plan_my_onco/shared/fluid/fluid_config.dart';
import 'package:plan_my_onco/shared/theme/app_colors.dart';
import 'package:plan_my_onco/shared/theme/app_images.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_my_onco/shared/widgets/button/primary_button.dart';
import 'package:plan_my_onco/ui/pages/onboarding/applications/onboarding_cubit.dart';
import 'package:plan_my_onco/ui/pages/onboarding/applications/onboarding_state.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final cubit = context.read<OnboardingCubit>();
            return Column(
              children: [
                // Top Images in PageView
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: PageView(
                      controller: cubit.pageController,
                      onPageChanged: cubit.onChangedPage,
                      children: [
                        Image.asset(AppImages.onboarding1, fit: BoxFit.cover),
                        Image.asset(AppImages.onboarding3, fit: BoxFit.cover),
                        Image.asset(AppImages.onboarding2, fit: BoxFit.cover),
                      ],
                    ),
                  ),
                ),
                // Bottom content container
                Transform.translate(
                  offset: const Offset(0, -24),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      top: 32.0,
                      bottom:
                          56.0, // Added 24px padding to bottom to cover up the shift gap
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // Take intrinsic height
                      children: [
                        // Logo simulation
                        Row(
                          children: [
                            Image.asset(
                              AppImages.splashImage,
                              height: 40,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.security,
                                    color: Color(0xFF9042F6),
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Title
                        Text(
                          _getTitles()[state.currentPage],
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: Fluid.fluid(16, 20),
                            fontWeight: FontWeight.w500,
                            height: 28 / 16,
                            letterSpacing: 0,

                            foreground: Paint()
                              ..shader =
                                  const LinearGradient(
                                    colors: <Color>[
                                      Color(0xff8921aa),
                                      Color(0xffDA44bb),
                                    ],
                                  ).createShader(
                                    const Rect.fromLTWH(0.0, 0.0, 500.0, 70.0),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Description
                        Text(
                          _getDescriptions()[state.currentPage],
                          style: TextStyle(
                            fontSize: Fluid.fluid(12, 14),
                            color: AppColors.greyText,
                            height: 1.4,
                            letterSpacing: 0.01,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ), // Replaced Spacer with fixed spacing
                        // Buttons
                        Row(
                          children: [
                            // Skip Button
                            SizedBox(
                              height: 56,
                              child: ElevatedButton(
                                onPressed: cubit.skip,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 3,
                                  shadowColor: AppColors.greyText.withOpacity(
                                    0.3,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                  ),
                                ),
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w400,
                                    fontSize: Fluid.fluid(12, 14),
                                    height: 17 / 12,
                                    letterSpacing: -0.018,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Next / Get Started Button
                            Expanded(
                              child: PrimaryButton(
                                text: state.currentPage == 2
                                    ? 'Get Started'
                                    : 'Next',
                                onPressed: () {
                                  if (state.currentPage == 2) {
                                    // Navigate to login/home
                                    // AutoRouter.of(context).pushNamed('/login');
                                  } else {
                                    cubit.nextPage();
                                  }
                                },
                                icon: state.currentPage != 2
                                    ? Icons.arrow_forward
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<String> _getTitles() {
    return [
      "Register & Upload Documents",
      "Expert Board Review & Consultation",
      "Personalized Treatment Plan",
    ];
  }

  List<String> _getDescriptions() {
    return [
      "Upload your medical reports to create your case\nand begin your care journey.",
      "Our cancer specialists carefully review your case\nand guide you with clear recommendations.",
      "Receive a treatment plan tailored to your\ncondition, with next steps and ongoing support.",
    ];
  }
}
