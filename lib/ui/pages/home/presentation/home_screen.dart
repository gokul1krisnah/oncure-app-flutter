import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/model/user/user_model.dart';
// import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_images.dart';
import '../../../widgets/button/primary_button.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = locator<Box<UserModel>>().get('user');




  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.kBg,
    extendBody: true,
    body: Stack(
      children: [
        Positioned(
          top: 0,
          // left: 0,
          right: 0,
          bottom: 0,
          child: Image.asset(AppImages.homeBg1, fit: BoxFit.cover),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          top: 0,
          right: 0,
          child: Image.asset(
            AppImages.homeBg2,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(150),
              _buildWelcomeCard(),
              const Gap(30),
              _buildFindDoctors(),
              const Gap(30),
              _buildBlogs(),
              const Gap(100),
            ],
          ),
        ),
        _buildAppBar(),
        const SizedBox(height: 12),
      ],
    ),

  );

  // ─── App Bar ─────────────────────────────────────────────────────────────────

  Widget _buildAppBar() => ClipRRect(
    child: SafeArea(
      bottom: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9.5, 10, 9.5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo image from assets
              Image.asset(AppImages.splashImage, height: 32, fit: BoxFit.contain),
              // Notification bell
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: AppColors.kPurple,
                      size: 22,
                    ),
                  ),
                  Positioned(
                    top: -1,
                    right: -1,
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE53935),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );

  // ─── Welcome Card ─────────────────────────────────────────────────────────────
  Widget _buildWelcomeCard() => Center(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          width: 400,
          height: 360,
          // reduced height (since no button inside)
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
              width: 0.81,
            ),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color.fromARGB(0, 255, 255, 255),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D0F0F0F),
                blurRadius: 24,
                offset: Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    /// 🔹 IMAGE
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color.from(
                              alpha: 0.4,
                              red: 0.816,
                              green: 0.816,
                              blue: 0.816,
                            ),
                            width: 0.81,
                          ),
                          gradient: const LinearGradient(
                            colors: [Colors.white, Colors.white],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Image.asset(
                                AppImages.home,
                                fit: BoxFit.contain,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// 🔹 TEXT OVERLAY
                    Positioned(
                      top: 10,
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                          child: Container(
                            height: 260,
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFFFFFFF), // solid white
                                  Color(0xCCFFFFFF), // semi transparent
                                  Color(0x66FFFFFF), // lighter fade
                                  Color(0x00FFFFFF), // fully transparent
                                ],
                                stops: [
                                  0.0,
                                  0.4,
                                  0.7,
                                  1.0,
                                ], // 👈 smoother transition
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Hey ',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xFF8B65D9),
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${user?.name ?? 'User'}!',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF8B65D9),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Start by registering your first case to manage your health details and connect with medical experts.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF1A1A1A),
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(16),
              PrimaryButton(
                // onTap: () {},
                text: 'Register Your New Case',
                fontWeight: FontWeight.w700,
                fontFamily: 'Manrope',
                onPressed: () {},
                icon: Icons.arrow_forward,
              ),
            ],
          ),
        ),
      ),
    ),
  );

  // ─── Find Doctors ─────────────────────────────────────────────────────────────
  Widget _buildFindDoctors() {
    final doctors = [
      const _DoctorModel(
        'Chris Friedkly',
        'Medical Oncologist',
        AppImages.doctorImage1,
        false,
      ),
      const _DoctorModel(
        'Maggie Johnson',
        'Radiation Oncologist',
        AppImages.doctorImage2,
        true,
      ),
      const _DoctorModel(
        'Gael Harry',
        'Specialized Oncologist',
        AppImages.doctorImage3,
        false,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Find Doctors',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.kPurple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(9),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color.fromARGB(102, 208, 208, 208), // cleaner border
              width: 0.8,
            ),
            color: Colors.white, // simpler than gradient
          ),
          child: Column(
            children: List.generate(
              3,
                  (index) => Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // navigation later
                      },
                      borderRadius: BorderRadius.circular(80),

                      splashColor: AppColors.buttonHover,
                      child: _DoctorTile(doctor: doctors[index]),
                    ),
                  ),
                  // if (index < 2) const Divider(
                  //   height: 1,
                  //   // thickness: 0.5,
                  //   color: Color(0xFFEEEEEE),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ─── Blogs ────────────────────────────────────────────────────────────────────
  Widget _buildBlogs() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Blogs',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D2D2D),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'See all',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.kPurple,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      const Gap(10),
      SizedBox(
        height: 162,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 2,
          separatorBuilder: (_, __) => const Gap(10),
          itemBuilder: (context, index) => _BlogCard(index: index),
        ),
      ),
    ],
  );

  // // ─── Bottom Nav Bar ───────────────────────────────────────────────────────────
  // Widget _buildBottomNavBar() => Container(
  //   margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
  //   decoration: BoxDecoration(
  //     color: Colors.white,
  //     borderRadius: BorderRadius.circular(32),
  //     boxShadow: [
  //       BoxShadow(
  //         color: Colors.black.withOpacity(0.10),
  //         blurRadius: 20,
  //         offset: const Offset(0, 4),
  //       ),
  //     ],
  //   ),
  //   child: ClipRRect(
  //     borderRadius: BorderRadius.circular(32),
  //     child: BottomAppBar(
  //       color: Colors.white,
  //       shape: const CircularNotchedRectangle(),
  //       notchMargin: 44,
  //       elevation: 0,
  //       padding: EdgeInsets.zero,
  //       child: SizedBox(
  //         height: 30,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             _NavItem(
  //               icon: Icons.home_outlined,
  //               selectedIcon: Icons.home_rounded,
  //               label: 'Home',
  //               selected: _selectedIndex == 0,
  //               onTap: () => setState(() => _selectedIndex = 0),
  //             ),
  //
  //             _NavItem(
  //               icon: Icons.person_outline_rounded,
  //               selectedIcon: Icons.person_rounded,
  //               label: 'Profile',
  //               selected: _selectedIndex == 1,
  //               onTap: () => setState(() => _selectedIndex = 1),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ),
  // );
}

// ─── Doctor Model ──────────────────────────────────────────────────────────────
class _DoctorModel {
  final String name;
  final String specialty;
  final String imagePath;
  final bool hasArrow;

  const _DoctorModel(this.name, this.specialty, this.imagePath, this.hasArrow);
}

// ─── Doctor Tile ──────────────────────────────────────────────────────────────
class _DoctorTile extends StatelessWidget {
  final _DoctorModel doctor;

  const _DoctorTile({required this.doctor});

  @override
  Widget build(BuildContext context) => ListTile(

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
    leading: Image.asset(
      doctor.imagePath,
      width: 46,
      height: 46,
      fit: BoxFit.cover,
    ),
    title: Text(
      doctor.name,
      style: const TextStyle(
        fontSize: 13.5,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2D2D2D),
      ),
    ),
    subtitle: Text(
      doctor.specialty,
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xFF9E8CB5),
        fontWeight: FontWeight.w400,
      ),
    ),


  );
}

// ─── Blog Card ────────────────────────────────────────────────────────────────
class _BlogCard extends StatelessWidget {
  final int index;

  const _BlogCard({required this.index});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 163,
    height: 162,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Real blog image — replace color container with Image.asset ──
          Image.asset(
            AppImages.bolgImage1,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xFFB39DDB),
              child: const Icon(Icons.image, color: Colors.white38, size: 40),
            ),
          ),

          // ── Dark gradient overlay from bottom ──
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.65)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.35, 1.0],
              ),
            ),
          ),

          // ── Bookmark icon top-right ──
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.88),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bookmark_border_rounded,
                size: 15,
                color: Color(0xFF7B5EA7),
              ),
            ),
          ),

          // ── Title bottom-left ──
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.35, 1.0],
                  colors: [
                    Colors.transparent,
                    const Color(0xFF8E63F2).withOpacity(0.5),
                  ],
                ),
              ),
              child: const Text(
                'Early Detection Saves Lives',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ─── Nav Item ─────────────────────────────────────────────────────────────────
// class _NavItem extends StatelessWidget {
//   final IconData icon;
//   final IconData selectedIcon;
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;
//
//   const _NavItem({
//     required this.icon,
//     required this.selectedIcon,
//     required this.label,
//     required this.selected,
//     required this.onTap,
//     super.key,
//   });

  // @override
  // Widget build(BuildContext context) => GestureDetector(
  //   onTap: onTap,
  //   behavior: HitTestBehavior.opaque,
  //   child: SizedBox(
  //     width: 64,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Icon(
  //           selected ? selectedIcon : icon,
  //           color: selected ? const Color(0xFF7B5EA7) : const Color(0xFFBDBDBD),
  //           size: 25,
  //         ),
  //         const SizedBox(height: 3),
  //         Text(
  //           label,
  //           style: TextStyle(
  //             fontSize: 10,
  //             color: selected
  //                 ? const Color(0xFF7B5EA7)
  //                 : const Color(0xFFBDBDBD),
  //             fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
// }


