import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:table_calendar/table_calendar.dart';

import '../../../../core/routes/app_router.gr.dart';
import '../../../../shared/fluid/fluid_config.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_images.dart';
import '../../../widgets/button/primary_button.dart';
import '../../../widgets/customs/calender_modal.dart';
// import '../../../widgets/customs/custom_calender.dart';
import '../../../widgets/forms/primary_text_form_field.dart';

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

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final LayerLink _genderLayerLink = LayerLink();
OverlayEntry? _genderOverlay;

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

  void _showCalendar() {
  CalendarModal.show(
    context: context,
    focusedDay: _focusedDay,
    selectedDay: _selectedDay,
    onDateSelected: (selectedDate) {
      setState(() {
        _selectedDay = selectedDate;
        _focusedDay = selectedDate;

        _dobController.text =
            '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
      });

      context.router.pop(); // close modal
    },
  );
}



void _showGenderSelector() {
  final genders = ['Male', 'Female', 'Other'];

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Select Gender'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: genders.map((gender) => ListTile(
              title: Text(gender),
              onTap: () {
                setState(() {
                  _genderController.text = gender;
                });
                Navigator.pop(context);
              },
            )).toList(),
        ),
      ),
  );
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
                  // back button
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
                  const Gap(40),
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
                          onTap: _showCalendar,
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
                          onTap: _showGenderSelector,
                          autoFocus: false,
                          readOnly:
                              true, // Likely opens a bottom sheet / dropdown
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
                      context.router.push(const HomeRoute());
                    },
                  ),
                  const Gap(12),

                  // Information securely stored text
                  Center(
                    child: Text(
                      'Your information is securely stored and used only for care\ncoordination.',
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
                        children: [
                          const TextSpan(
                            text: 'By registering, you agree to the ',
                          ),
                          TextSpan(
                            text: 'Terms & Conditions\n',
                            style: TextStyle(
                              // color: Color(0xFF4A4A4A),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w400,
                              fontSize: Fluid.fluid(10, 12),
                            ),
                          ),
                          const TextSpan(text: 'and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              // color: Color(0xFF4A4A4A),
                              decoration: TextDecoration.underline,
                              fontSize: Fluid.fluid(10, 12),
                            ),
                          ),
                          TextSpan(
                            text: ' of PlanMyOnco platform.',
                            style: TextStyle(fontSize: Fluid.fluid(10, 12)),
                          ),
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
