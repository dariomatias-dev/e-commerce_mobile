import 'package:flutter/material.dart';

import 'package:power_tech/screens/main_screen/components/drawer_widget/main.dart';
import 'package:power_tech/screens/home_screen/components/section_products/main.dart';

import 'package:power_tech/widgets/custom_app_bar_widget/main.dart';

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
      appBar: CustomAppBarWidget(
        title: "Power Tech",
        actionIcon: Icons.notifications,
        actionIconTooltip: "Notificações",
        actionIconFunction: () {
          Navigator.pushNamed(context, "notifications");
        },
        scaffoldKey: _scaffoldKey,
      ),
      body: const SectionProducts(),
      drawer: const DrawerWidget(),
    );
  }
}
