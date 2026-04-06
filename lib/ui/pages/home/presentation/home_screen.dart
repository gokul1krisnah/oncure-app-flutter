import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/model/user/user_model.dart';
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
  int _selectedIndex = 0;

  static const Color kPurple = Color(0xFF7B5EA7);
  static const Color kPrimaryDark = Color(0xFF3D2B6B);
  static const Color kBg = Color(0xFFF0F0F5);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: kBg,
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(),
                const SizedBox(height: 12),
                _buildWelcomeCard(),
                const SizedBox(height: 16),
                _buildFindDoctors(),
                const SizedBox(height: 16),
                _buildBlogs(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: kPurple,
          elevation: 6,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );

  // ─── App Bar ─────────────────────────────────────────────────────────────────
  Widget _buildAppBar() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
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
                    color: kPurple,
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
      );

  // ─── Welcome Card ─────────────────────────────────────────────────────────────
  Widget _buildWelcomeCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // ── Background floral/splash image (right side, semi-transparent) ──
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.white,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.45],
                    ).createShader(bounds),
                    blendMode: BlendMode.dstOut,
                    child: Opacity(
                      opacity: 0.55,
                      child: Image.asset(
                        AppImages.home,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              // ── Foreground text + button ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hey {name}!
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Hey ',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF3D2B6B),
                            ),
                          ),
                          TextSpan(
                            text: '${user?.name ?? 'Praveen'}!',
                            style: const TextStyle(
                              fontSize: 24,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3D2B6B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Start by registering your first case to manage\nyour health details and connect with medical\nexperts.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF999999),
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 95),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: 'Register Your New Case',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  // ─── Find Doctors ─────────────────────────────────────────────────────────────
  Widget _buildFindDoctors() {
    final doctors = [
      const _DoctorModel('Chris Friedkly', 'Medical Oncologist',
          'assets/images/doctor1.png', false),
      const _DoctorModel('Maggie Johnson', 'Radiation Oncologist',
          'assets/images/doctor2.png', true),
      const _DoctorModel('Gael Harry', 'Specialized Oncologist',
          'assets/images/doctor3.png', false),
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
                    color: kPurple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: doctors.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              thickness: 0.5,
              indent: 62,
              endIndent: 16,
              color: Color(0xFFEEEEEE),
            ),
            itemBuilder: (context, index) =>
                _DoctorTile(doctor: doctors[index]),
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
                      color: kPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 162,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => _BlogCard(index: index),
            ),
          ),
        ],
      );

  // ─── Bottom Nav Bar ───────────────────────────────────────────────────────────
  Widget _buildBottomNavBar() => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BottomAppBar(
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8,
            elevation: 0,
            padding: EdgeInsets.zero,
            child: SizedBox(
              height: 62,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home_rounded,
                    label: 'Home',
                    selected: _selectedIndex == 0,
                    onTap: () => setState(() => _selectedIndex = 0),
                  ),
                  const SizedBox(width: 64),
                  _NavItem(
                    icon: Icons.person_outline_rounded,
                    selectedIcon: Icons.person_rounded,
                    label: 'Profile',
                    selected: _selectedIndex == 1,
                    onTap: () => setState(() => _selectedIndex = 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: const Color(0xFFEDE7F6),
          backgroundImage: AssetImage(doctor.imagePath),
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
        trailing: doctor.hasArrow
            ? Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: Color(0xFF7B5EA7),
                ),
              )
            : null,
      );
}

// ─── Blog Card ────────────────────────────────────────────────────────────────
class _BlogCard extends StatelessWidget {
  final int index;
  const _BlogCard({required this.index});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 148,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Real blog image — replace color container with Image.asset ──
              Image.asset(
                'assets/images/blog${index + 1}.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFB39DDB),
                  child: const Icon(Icons.image,
                      color: Colors.white38, size: 40),
                ),
              ),

              // ── Dark gradient overlay from bottom ──
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
              const Positioned(
                left: 10,
                right: 10,
                bottom: 10,
                child: Text(
                  'Early Detection Saves Lives',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

// ─── Nav Item ─────────────────────────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon, required this.selectedIcon, required this.label, required this.selected, required this.onTap, super.key,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected ? selectedIcon : icon,
                color: selected
                    ? const Color(0xFF7B5EA7)
                    : const Color(0xFFBDBDBD),
                size: 25,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: selected
                      ? const Color(0xFF7B5EA7)
                      : const Color(0xFFBDBDBD),
                  fontWeight:
                      selected ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
}