import 'package:flutter/material.dart';

import 'package:power_tech/screens/home_screen/section_products/main.dart';
import 'package:power_tech/screens/main_screen/drawer_widget/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: const Tooltip(
            message: "Abrir menu",
            child: Icon(
              Icons.menu,
              color: Colors.black,
              size: 32,
            ),
          ),
        ),
        title: const Text(
          "Power Tech",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          Icon(
            Icons.notifications_none_sharp,
              color: Colors.grey.shade800,
          ),
          const SizedBox(width: 6),
        ],
      ),
      drawer: const DrawerWidget(),
      body: const SectionProducts(),
    );
  }
}
