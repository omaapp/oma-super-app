import 'package:flutter/material.dart';

import 'home_screen.dart';
import '../../trips/presentation/trips_screen.dart';
import '../../../profile/presentation/profile_screen.dart';

class CustomerMainScreen extends StatefulWidget {
  const CustomerMainScreen({super.key});

  @override
  State<CustomerMainScreen> createState() => _CustomerMainScreenState();
}

class _CustomerMainScreenState extends State<CustomerMainScreen> {
  int currentIndex = 0;

  final pages = const [
    HomeScreen(),
    TripsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,

        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "الرئيسية",
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            label: "رحلاتي",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "الحساب",
          ),
        ],
      ),
    );
  }
}