import 'package:flutter/material.dart';
import 'package:power_tech/widgets/custom_drawer_widget/main.dart';

class CustomScaffoldWidget extends StatelessWidget {
  CustomScaffoldWidget({super.key, required this.body});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Widget body;

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
      body: body,
    );
  }
}
