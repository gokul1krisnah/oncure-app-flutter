import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../shared/fluid/fluid_config.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_images.dart';
import '../../../../shared/widgets/button/primary_button.dart';
import '../../../../shared/widgets/forms/primary_text_form_field.dart';


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
  Widget build(BuildContext context) => Scaffold(
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
                  // Placeholder for removed Back Button to maintain layout
                  const SizedBox(height: 48),
                  const SizedBox(height: 60),
                  // Logo
                  Center(
                    child: Image.asset(
                      AppImages.splashImage,
                      height: 52,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.security,
                        size: 52,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 64),
                  // Sign in Text
                  Text(
                    'Sign in',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: Fluid.fluid(18, 24),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E1E1E), // Slightly softer black
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'to access Plan My Onco portal',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: Fluid.fluid(12, 18),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF0C0C0C),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Email / Mobile Field
                  PrimaryTextFormField(
                    controller: _emailOrMobileController,
                    hintText: 'Email address or mobile number',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  // Continue Button
                  PrimaryButton(
                    text: 'Continue',
                    fontWeight: FontWeight.bold,
                    onPressed: () {
                      context.router.push(const VerifyRoute());
                    },
                  ),
                  const SizedBox(height: 32),
                  // OR Divider
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(color: Color(0xFFE5E5E5), thickness: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          ' or',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            color: const Color(0xFF4B4B4B),
                            fontSize: Fluid.fluid(12, 18),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(color: Color(0xFFE5E5E5), thickness: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Google Sign in Button
                  SizedBox(
                    height: 56, // Match PrimaryButton height roughly
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Implement Google Sign in
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: const BorderSide(color: Color(0xFFE5E5E5)),
                        elevation: 0,
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
                              fontSize: Fluid.fluid(12, 18),
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Terms & Conditions
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
                          TextSpan(text: 'By continuing, you agree to the '),
                          TextSpan(
                            text: 'Terms & Conditions\n',
                            style: TextStyle(
                              color: Color(0xFF4A4A4A),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(text: 'and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Color(0xFF4A4A4A),
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
