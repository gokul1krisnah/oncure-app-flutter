import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routes/app_router.gr.dart';
import '../../../shared/fluid/fluid_config.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_images.dart';
import '../../../shared/widgets/button/primary_button.dart';
import 'applications/onboarding_cubit.dart';
import 'applications/onboarding_state.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final cubit = context.read<OnboardingCubit>();
            final int currentPage = state is CurrentPage ? state.currentPage : 0;
            return Column(
              children: [
                // Top Images in PageView
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: PageView(
                      controller: _pageController,
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
                    padding: const  EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 32,
                      bottom:
                          56, // Added 24px padding to bottom to cover up the shift gap
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
                          _getTitles()[currentPage],
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
                                    const Rect.fromLTWH(0, 0, 500, 70),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Description
                        Text(
                          _getDescriptions()[currentPage],
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
                                onPressed: () {
                                  _pageController.animateToPage(
                                    2,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 3,
                                  // ignore: deprecated_member_use
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
                                text: currentPage == 2
                                    ? 'Get Started'
                                    : 'Next',
                                onPressed: () {
                                  if (currentPage == 2) {
                                    AutoRouter.of(context).replace(const LoginRoute());
                                  } else {
                                    _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                icon: currentPage != 2
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

  List<String> _getTitles() => [
      'Register & Upload Documents',
      'Expert Board Review & Consultation',
      'Personalized Treatment Plan',
    ];

  List<String> _getDescriptions() => [
      'Upload your medical reports to create your case\nand begin your care journey.',
      'Our cancer specialists carefully review your case\nand guide you with clear recommendations.',
      'Receive a treatment plan tailored to your\ncondition, with next steps and ongoing support.',
    ];
}
