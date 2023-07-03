import 'package:flutter/material.dart';
import 'package:power_tech/widgets/custom_drawer_widget/custom_drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(),
    );
  }
}
