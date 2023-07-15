import 'package:flutter/material.dart';

import 'package:power_tech/providers/main_screen_context_inherited.dart';

import 'package:power_tech/screens/main_screen/drawer_widget/main.dart';
import 'package:power_tech/screens/main_screen/bottomnavigationbar_main_widget.dart';
import 'package:power_tech/screens/home_screen/main.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedTab = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(
      child: Text(
        "Favoritos",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    const Center(
      child: Text(
        "Carrinho",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
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
      key: _scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: const Tooltip(
            message: "Abrir menu",
            child: Icon(Icons.menu),
          ),
        ),
        title: const Text("Power Tech"),
        backgroundColor: Colors.black,
      ),
      drawer: const DrawerWidget(),
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
