import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/injection/injection.dart';
// import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_images.dart';
import '../../../widgets/button/primary_button.dart';
import '../applications/home_cubit.dart';
import '../applications/home_state.dart';
import '../data/model/blog/blog_model.dart';
import '../data/model/doctor/doctor_model.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider(create: (context) => locator<HomeCubit>()..loadDoctorList(), child: this);
}

class _HomeScreenState extends State<HomeScreen> {
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
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9.5, 10, 9.5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo image from assets
              Image.asset(
                AppImages.splashImage,
                height: 32,
                fit: BoxFit.contain,
              ),
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
                AppColors.white,
                AppColors.white,
                AppColors.linearGradient,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.boxShadow,
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
                      child: DecoratedBox(
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
                            colors: [AppColors.white, AppColors.white],
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
                                  AppColors.solidWhite, // solid white
                                  AppColors.semiTransperent, // semi transparent
                                  AppColors.lighterFade, // lighter fade
                                  AppColors.fullyTransperent,// fully transparent
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
                                BlocBuilder<HomeCubit, HomeState>(
                                  builder: (context, state) => state.maybeWhen(
                                      loaded: (user,doctors,blogs) => Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Hey ',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w300,
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '${user?.name ?? 'User'}!',
                                                style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      
                                      orElse: () => const Text('Hey User!'),
                                    ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Start by registering your first case to manage your health details and connect with medical experts.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textBlack,
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
 Widget _buildFindDoctors() => BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) => state.maybeWhen(
    loaded: (user, doctors, blogs) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Header
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

        // 🔥 IMPORTANT PART
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color.fromARGB(102, 208, 208, 208),
                  width: 0.8,
                ),
              ),
              child: Column(
                children: doctors.map((doctor) => InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(70),
                    splashColor: AppColors.buttonHover,
                    child: _DoctorTile(
                      doctor: doctor, // ✅ DIRECT FROM STATE
                    ),
                  )).toList(),
              ),
            ),
          ),
        ),
      ],
    ),
    orElse: () => const SizedBox(),
  ),
);

  // ─── Blogs ────────────────────────────────────────────────────────────────────
  Widget _buildBlogs() => BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) => state.maybeWhen(
    loaded: (user, doctors, blogs) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Header
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

        // 🔥 BLOG LIST
        SizedBox(
          height: 162,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: blogs.length, // ✅ dynamic
            separatorBuilder: (_, __) => const Gap(10),
            itemBuilder: (context, index) {
              final blog = blogs[index];
              return _BlogCard(blog: blog); // ✅ pass blog
            },
          ),
        ),
      ],
    ),
    orElse: () => const SizedBox(),
  ),
);
}

// ─── Doctor Model ──────────────────────────────────────────────────────────────


// ─── Doctor Tile ──────────────────────────────────────────────────────────────
class _DoctorTile extends StatelessWidget {
  final DoctorModel doctor;

  const _DoctorTile({required this.doctor});

  @override
  Widget build(BuildContext context) => ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 5),

        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            AppImages.doctorImage1, // temp (API has no image yet)
            width: 46,
            height: 46,
            fit: BoxFit.cover,
          ),
        ),

        title: Text(
          doctor.name, // ✅ FROM REPOSITORY
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
          ),
        ),

        subtitle: Text(
          doctor.specialization, // ✅ FROM REPOSITORY
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
  final BlogModel blog;

  const _BlogCard({required this.blog});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 163,
        height: 162,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 🔹 Image (static for now)
              Image.asset(
                AppImages.bolgImage1,
                fit: BoxFit.cover,
              ),

              // 🔹 Gradient overlay
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.65),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.35, 1.0],
                  ),
                ),
              ),

              // 🔹 Bookmark icon
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

              // 🔹 Blog Title (FROM API)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    blog.title, // ✅ dynamic from repo
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
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