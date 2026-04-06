import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../shared/fluid/fluid_config.dart';
import '../../../../shared/snackbar_alerts/snack_alert.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_images.dart';
import '../../../widgets/button/primary_button.dart';
import '../../../widgets/forms/primary_text_form_field.dart';
import '../application/login_page/login_cubit.dart';
import '../application/login_page/login_state.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailOrMobileController;

  @override
  void initState() {
    super.initState();
    _emailOrMobileController = TextEditingController();
  }

  @override
  void dispose() {
    _emailOrMobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => LoginCubit(),
    child: BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          success: () {},
          error: (message) {
            SnackBarAlert().showToast(message: message, isWarning: true);
          },
          navigateToLogin: () {
            context.router.push(const VerifyRoute());
          },
        );
      },

      // ✅ UI
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),
                      const SizedBox(height: 48),
                      const SizedBox(height: 60),

                      // Logo
                      Center(
                        child: Image.asset(
                          AppImages.splashImage,
                          height: 52,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.security,
                                size: 52,
                                color: AppColors.primary,
                              ),
                        ),
                      ),

                      const SizedBox(height: 64),

                      // Title
                      Text(
                        'Sign in',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: Fluid.fluid(18, 24),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'to access Plan My Onco portal',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: Fluid.fluid(12, 18),
                          color: const Color(0xFF0C0C0C),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Input
                      PrimaryTextFormField(
                        controller: _emailOrMobileController,
                        hintText: 'Email address or mobile number',
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 24),

                      // Button
                      PrimaryButton(
                        text: 'Continue',
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          final input = _emailOrMobileController.text.trim();

                          context.read<LoginCubit>().login(input);
                        },
                      ),

                      const SizedBox(height: 32),

                      // Divider
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: Color(0xFFE5E5E5),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              ' or',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: Fluid.fluid(12, 18),
                                color: const Color(0xFF4B4B4B),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: Color(0xFFE5E5E5),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Google Button
                      SizedBox(
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            side: const BorderSide(color: Color(0xFFE5E5E5)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildGoogleIconPlaceholder(),
                              const SizedBox(width: 12),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  color: const Color(0xFF414651),
                                  fontSize: Fluid.fluid(12, 18),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),

                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              fontSize: Fluid.fluid(10, 18),
                              color: const Color(0xFF8C8C8C),
                              height: 1.5,
                            ),
                            children: const [
                              TextSpan(
                                text: 'By continuing, you agree to the ',
                              ),
                              TextSpan(
                                text: 'Terms & Conditions\n',
                                style: TextStyle(
                                  // color: Color(0xFF4A4A4A),
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(text: 'and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  // color: Color(0xFF4A4A4A),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: ' of PlanMyOnco platform.'),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildGoogleIconPlaceholder() => Container(
    width: 24,
    height: 24,
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Image.asset(
        AppImages.googleIcon,
        width: 30,
        height: 30,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.g_mobiledata, color: Colors.blue, size: 24),
      ),
    ),
  );
}
