import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../shared/fluid/fluid_config.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_images.dart';
import '../../../../shared/widgets/button/primary_button.dart';


@RoutePage()
class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
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
                  const Gap(24),
                  // Placeholder for removed Back Button to maintain layout
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF5F5F5),
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
                  Pinput(
                  length: 6,
                  keyboardType: TextInputType.number,
                  defaultPinTheme: PinTheme(
                    width: 44,
                    height: 44,
                    textStyle:  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    ),decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:  BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E5E5)
                      )
                    )
                  ),
                  focusedPinTheme: PinTheme(
                    width: 44,
                    height: 44,
                    textStyle:  const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,

                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary,
                        width: 1.2
                      )
                    )
                  ),
                  ),
                  // Email / Mobile Field
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: List.generate(
                  //     6,
                  //     (index) => SizedBox(
                  //       width: 44, // 🔥 slightly better spacing than 40
                  //       height: 44,
                  //       child: TextField(
                  //         textAlign: TextAlign.center,
                  //         keyboardType: TextInputType.number,
                  //         maxLength: 1,
                  //         style: const TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //         decoration: InputDecoration(
                  //           counterText: '',
                  //           filled: true,
                  //           fillColor:
                  //               Colors.white, // 🔥 Figma looks white, not grey
                  //           // 🔥 IMPORTANT: remove weird padding
                  //           contentPadding: EdgeInsets.zero,

                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(
                  //               12,
                  //             ), // 🔥 matches Figma
                  //             borderSide: const BorderSide(
                  //               color: Color(0xFFE5E5E5),
                  //             ),
                  //           ),

                  //           enabledBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(12),
                  //             borderSide: const BorderSide(
                  //               color: Color(0xFFE5E5E5),
                  //             ),
                  //           ),

                  //           focusedBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(12),
                  //             borderSide: const BorderSide(
                  //               color:
                  //                   AppColors.primary, // or your primary color
                  //               width: 1.2,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const Gap(27),
                  // Continue Button
                  PrimaryButton(
                    text: 'Verify OTP',

                    fontWeight: FontWeight.bold,
                    onPressed: () {
                      context.router.push(const CreateAccountRoute());
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
                          fontSize: Fluid.fluid(10, 1),
                          color: const Color(0xFF8C8C8C),
                          height: 1.5,
                        ),
                        children: const [
                          TextSpan(text: 'By verifying, you agree to the '),
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
                  const Gap(32),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
