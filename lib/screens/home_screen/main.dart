import 'package:flutter/material.dart';
import 'package:power_tech/screens/home_screen/section_products/main.dart';

import 'package:power_tech/widgets/custom_drawer_widget/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: const CustomDrawer(),
      body: const SectionProducts(),
    );
  }
}
