import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../shared/theme/app_images.dart';
import '../../../widgets/button/primary_button.dart';
@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF0F0F5),
        body: SafeArea(
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
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF7B5EA7),
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );

  // ─── App Bar ────────────────────────────────────────────────────────────────
  Widget _buildAppBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppImages.splashImage,
                      height: 28,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: const Icon(Icons.notifications_outlined,
                      color: Color(0xFF7B5EA7), size: 22),
                ),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                        color: Color(0xFFE53935), shape: BoxShape.circle),
                    child: const Center(
                      child: Text('3',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  // ─── Welcome Card ────────────────────────────────────────────────────────────
  Widget _buildWelcomeCard() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Stack(
            children: [
              // ── splashBottom as right-side background with transparency ──
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Opacity(
                    opacity: 0.45, // 👈 adjust 0.0–1.0 for more/less transparency
                    child: Image.asset(
                      AppImages.splashBottom,
                      fit: BoxFit.cover,
                      width: 180,
                    ),
                  ),
                ),
              ),

              // ── Foreground content ──
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hey Praveen!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3D2B6B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Start by registering your first case to manage\nyour health details and connect with medical\nexperts.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF888888),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 100),
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

  // ─── Find Doctors ────────────────────────────────────────────────────────────
  Widget _buildFindDoctors() {
    final doctors = [
      _DoctorModel('Chris Friedkly', 'Medical Oncologist',
          'assets/images/doctor1.png', false),
      _DoctorModel('Maggie Johnson', 'Radiation Oncologist',
          'assets/images/doctor2.png', true),
      _DoctorModel('Gael Harry', 'Specialized Oncologist',
          'assets/images/doctor3.png', false),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Find Doctors',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D2D2D))),
              TextButton(
                onPressed: () {},
                child: const Text('See all',
                    style: TextStyle(fontSize: 13, color: Color(0xFF7B5EA7))),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2))
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: doctors.length,
            separatorBuilder: (_, __) => const Divider(
                height: 1, thickness: 0.5, indent: 60, endIndent: 16),
            itemBuilder: (context, index) {
              final doc = doctors[index];
              return _DoctorTile(doctor: doc);
            },
          ),
        ),
      ],
    );
  }

  // ─── Blogs ───────────────────────────────────────────────────────────────────
  Widget _buildBlogs() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Blogs',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D2D2D))),
                TextButton(
                  onPressed: () {},
                  child: const Text('See all',
                      style:
                          TextStyle(fontSize: 13, color: Color(0xFF7B5EA7))),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 160,
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

  // ─── Bottom Nav Bar ──────────────────────────────────────────────────────────
  Widget _buildBottomNavBar() => BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 12,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: 'Home',
                selected: _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0),
              ),
              const SizedBox(width: 48), // space for FAB notch
              _NavItem(
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: 'Profile',
                selected: _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1),
              ),
            ],
          ),
        ),
      );
}

// ─── Doctor Model ─────────────────────────────────────────────────────────────
class _DoctorModel {
  final String name;
  final String specialty;
  final String imagePath;
  final bool hasArrow;
  _DoctorModel(this.name, this.specialty, this.imagePath, this.hasArrow);
}

// ─── Doctor Tile ─────────────────────────────────────────────────────────────
class _DoctorTile extends StatelessWidget {
  final _DoctorModel doctor;
  const _DoctorTile({required this.doctor});

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage(doctor.imagePath),
          backgroundColor: const Color(0xFFEDE7F6),
        ),
        title: Text(doctor.name,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D2D2D))),
        subtitle: Text(doctor.specialty,
            style: const TextStyle(fontSize: 12, color: Color(0xFF9E8CB5))),
        trailing: doctor.hasArrow
            ? Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_forward_ios,
                    size: 14, color: Color(0xFF7B5EA7)),
              )
            : null,
      );
}

// ─── Blog Card ────────────────────────────────────────────────────────────────
class _BlogCard extends StatelessWidget {
  final int index;
  const _BlogCard({required this.index});

  @override
  Widget build(BuildContext context) => Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        child: Stack(
          children: [
            // Blog image — swap Container with:
            // Image.asset('assets/images/blog${index + 1}.jpg',
            //   fit: BoxFit.cover, width: double.infinity, height: double.infinity)
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xFFB39DDB),
                child:
                    const Icon(Icons.image, color: Colors.white54, size: 48),
              ),
            ),

            // Gradient overlay
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black54],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Bookmark icon
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.bookmark_border,
                    size: 16, color: Color(0xFF7B5EA7)),
              ),
            ),

            // Title
            const Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Text(
                'Early Detection Saves Lives',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.3),
              ),
            ),
          ],
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
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected ? selectedIcon : icon,
                color: selected
                    ? const Color(0xFF7B5EA7)
                    : const Color(0xFFBDBDBD),
                size: 24,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: selected
                      ? const Color(0xFF7B5EA7)
                      : const Color(0xFFBDBDBD),
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
}
