import 'package:flutter/material.dart';
import 'package:power_tech/screens/home_screen/main.dart';

import 'package:power_tech/widgets/custom_drawer_widget/main.dart';
import 'package:power_tech/screens/main_screen/custom_bottomnavigationbar_widget.dart';

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
    const Text("Favoritos"),
    const Text("Carrinho"),
    const Text("Configurações"),
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
        backgroundColor: Colors.black,
      ),
      drawer: const CustomDrawer(),
      body: IndexedStack(
        index: _selectedTab,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTabSelector: onTabSelector,
      ),
    );
  }
}
