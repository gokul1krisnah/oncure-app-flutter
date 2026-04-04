import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../shared/fluid/fluid_config.dart';
import '../../../../shared/snackbar_alerts/snack_alert.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_images.dart';
import '../../../widgets/button/primary_button.dart';
import '../application/otp_page/verify_cubit.dart';
import '../application/otp_page/verify_state.dart';

@RoutePage()
class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  late final TextEditingController _emailOrMobileController;
  late final TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _emailOrMobileController = TextEditingController();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _emailOrMobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(create: (_) => VerifyCubit(),
    
    child: BlocListener<VerifyCubit, VerifyState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          error: (error) {
            SnackBarAlert().showToast(message: error, isWarning: true);
          },
          navigateToCreateAccount: () {
            context.router.push(const CreateAccountRoute());
          },
        );
      },
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
                  const Gap(24),
  
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        context.router.pop();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const Gap(60),
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
                  const Gap(64),
                  // Sign in Text
                  Text(
                    'Verify My Account',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: Fluid.fluid(18, 24),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E1E1E), // Slightly softer black
                      height: 1.2,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    'Please enter the 6-digit OTP sent to your email \n a***@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: Fluid.fluid(12, 18),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF0C0C0C),
                    ),
                  ),
                  const Gap(32),
                  //PinPut Field
                  Pinput(
                    controller: _otpController,
                    length: 6,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: PinTheme(
                      width: 44,
                      height: 44,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5E5E5)),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 44,
                      height: 44,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const Gap(27),
                  // Continue Button
                  PrimaryButton(
                    text: 'Verify OTP',
                    fontWeight: FontWeight.bold,
                    onPressed: () {
                      final otp = _otpController.text.trim();
                      context.read<VerifyCubit>().verifyOtp(otp);
  
                    },
                  ),
                  const Gap(12),
                  Center(
                    child: Text(
                      "Didn't get the code? Resend",
                      style: TextStyle(
                        fontSize: Fluid.fluid(12, 16),
                        color: const Color(0xFF0C0C0C),
                        fontWeight: FontWeight.w400,
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
                          fontSize: Fluid.fluid(10, 16),
                          color: const Color(0xFF8C8C8C),
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(text: 'By verifying, you agree to the '),
                          TextSpan(
                            text: 'Terms & Conditions\n',
                            style: TextStyle(
                              // color: Color(0xFF4A4A4A),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w400,
                              fontSize: Fluid.fluid(10, 16),
                            ),
                          ),
                          const TextSpan(text: 'and '),
                          const TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              // color: Color(0xFF4A4A4A),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: ' of PlanMyOnco platform.'),
                        ],
                      ),
                    ),
                  ),
                  const Gap(32),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  
    )
  )
  );
}
