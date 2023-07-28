import 'package:flutter/material.dart';

import 'package:power_tech/screens/home_screen/components/section_products/main.dart';
import 'package:power_tech/screens/main_screen/components/drawer_widget/main.dart';

import 'package:power_tech/widgets/open_drawer_button_widget.dart';

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
        leading: OpenDrawerButtonWidget(
          scaffoldKey: _scaffoldKey,
        ),
        centerTitle: true,
        title: const Text(
          "Power Tech",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        backgroundColor: Colors.white,
        actions: const <Widget>[
          Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          SizedBox(width: 6),
        ],
      ),
      drawer: const DrawerWidget(),
      body: const SectionProducts(),
    );
  }
}
