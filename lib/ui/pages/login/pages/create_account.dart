import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../shared/fluid/fluid_config.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_images.dart';
import '../../../../shared/widgets/button/primary_button.dart';
import '../../../../shared/widgets/forms/primary_text_form_field.dart';
@RoutePage()
class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _dobController;
  late final TextEditingController _genderController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _dobController = TextEditingController();
    _genderController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _addressController.dispose();
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
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Gap(24),
                      // Back Button
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
                      const Gap(40), // Adjusted from 60 due to more content
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
                      const Gap(24),
                      // Title Text
                      Center(
                        child: Text(
                          'Create Your Account',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: Fluid.fluid(20, 24),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E1E1E), // Slightly softer black
                            height: 1.2,
                          ),
                        ),
                      ),
                      const Gap(32),
                      
                      // Name Field
                      PrimaryTextFormField(
                        label: 'Name',
                        controller: _nameController,
                        hintText: 'Full Name',
                        keyboardType: TextInputType.name,
                        autoFocus: false,
                      ),
                      const Gap(16),
                      
                      // Email Field
                      PrimaryTextFormField(
                        label: 'Email ID',
                        controller: _emailController,
                        hintText: 'name@example.com',
                        keyboardType: TextInputType.emailAddress,
                        autoFocus: false,
                      ),
                      const Gap(16),
                      
                      // Row for Date of Birth & Gender
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryTextFormField(
                              label: 'Date of Birth',
                              controller: _dobController,
                              hintText: 'Select date',
                              autoFocus: false,
                              readOnly: true, // Likely opens a date picker
                              prefixIcon: const Icon(
                                Icons.calendar_today_outlined,
                                size: 20,
                                color: Color(0xFFB0B0B0),
                              ),
                            ),
                          ),
                          const Gap(16),
                          Expanded(
                            child: PrimaryTextFormField(
                              label: 'Gender',
                              controller: _genderController,
                              hintText: 'Select gender',
                              autoFocus: false,
                              readOnly: true, // Likely opens a bottom sheet / dropdown
                              suffixIcon: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 24,
                                color: Color(0xFFB0B0B0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(16),

                      // Address Field
                      PrimaryTextFormField(
                        label: 'Address',
                        controller: _addressController,
                        hintText: 'City, State',
                        keyboardType: TextInputType.streetAddress,
                        autoFocus: false,
                      ),
                      const Gap(32),

                      // Create Account Button
                      PrimaryButton(
                        text: 'Create Account',
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          // TODO: implement account creation
                        },
                      ),
                      const Gap(12),
                      
                      // Information securely stored text
                      Center(
                        child: Text(
                          "Your information is securely stored and used only for care\ncoordination.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: Fluid.fluid(10, 12),
                            color: const Color(0xFFAFAFAF),
                            fontWeight: FontWeight.w400,
                            height: 1.4,
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
                              fontSize: Fluid.fluid(10, 12),
                              color: const Color(0xFF8C8C8C),
                              height: 1.5,
                            ),
                            children: const [
                              TextSpan(
                                text: 'By registering, you agree to the ',
                              ),
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
