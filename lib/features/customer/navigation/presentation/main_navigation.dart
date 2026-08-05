import 'package:flutter/material.dart';

import '../../home/presentation/home_screen.dart';
import '../../trips/presentation/trips_screen.dart';
import '../../wallet/presentation/wallet_screen.dart';
import '../../../profile/presentation/profile_screen.dart';
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() =>
      _MainNavigationState();
}

class _MainNavigationState
    extends State<MainNavigation> {

  int current = 0;

  final pages = const [
  HomeScreen(),
  TripsScreen(),
  WalletScreen(),
  ProfileScreen(),
];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[current],

      bottomNavigationBar: NavigationBar(

        selectedIndex: current,

        onDestinationSelected: (i) {

          setState(() {

            current = i;

          });

        },

        destinations: const [

          NavigationDestination(

            icon: Icon(Icons.home_outlined),

            selectedIcon: Icon(Icons.home),

            label: "الرئيسية",
          ),

          NavigationDestination(

            icon: Icon(Icons.history_outlined),

            selectedIcon: Icon(Icons.history),

            label: "رحلاتي",
          ),

          NavigationDestination(

            icon: Icon(Icons.account_balance_wallet_outlined),

            selectedIcon: Icon(Icons.account_balance_wallet),

            label: "المحفظة",
          ),

          NavigationDestination(

            icon: Icon(Icons.person_outline),

            selectedIcon: Icon(Icons.person),

            label: "حسابي",
          ),
        ],
      ),
    );
  }
}