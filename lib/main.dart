import 'package:flutter/material.dart';
import 'package:power_tech/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Power Tech App",
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
      },
    );
  }
}
