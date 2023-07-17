import 'package:flutter/material.dart';

import 'package:power_tech/providers/main_screen_context_inherited.dart';

import 'package:power_tech/screens/cart_screen/main.dart';
import 'package:power_tech/screens/home_screen/main.dart';
import 'package:power_tech/screens/main_screen/components/bottomnavigationbar_main_widget.dart';
import 'package:power_tech/screens/wishlist_screen/main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const Center(
      child: Text(
        "Configurações",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ];

  void onTabSelector(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainScreenContextInherited(
        screenContext: context,
        child: IndexedStack(
          index: _selectedTab,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBarMainWidget(
        onTabSelector: onTabSelector,
      ),
    );
  }
}
