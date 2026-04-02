import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xFFF6F4FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.blur_circular, color: Colors.purple),
                      SizedBox(width: 8),
                      Text(
                        'Plan My Onco',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.notifications, color: Colors.black),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // Greeting Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hey Praveen!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Start by registering your first case to manage your health details and connect with medical experts.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.deepPurple],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          'Register Your New Case →',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Find Doctors
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Find Doctors',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('See all', style: TextStyle(color: Colors.purple))
                ],
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    DoctorTile(name: 'Chris Friedly', role: 'Medical Oncologist'),
                    DoctorTile(name: 'Maggie Johnson', role: 'Radiation Oncologist'),
                    DoctorTile(name: 'Gael Harry', role: 'Specialized Oncologist'),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              // Blogs
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Blogs',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('See all', style: TextStyle(color: Colors.purple))
                ],
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    BlogCard(),
                    BlogCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Nav
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
}

class DoctorTile extends StatelessWidget {
  final String name;
  final String role;

  const DoctorTile({required this.name, required this.role, super.key});

  @override
  Widget build(BuildContext context) => ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(name),
      subtitle: Text(role, style: const TextStyle(color: Colors.purple)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
}

class BlogCard extends StatelessWidget {
  const BlogCard({super.key});

  @override
  Widget build(BuildContext context) => Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade300,
      ),
      child: const Center(child: Text('Blog Image')),
    );
}
