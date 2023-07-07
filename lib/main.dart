import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:power_tech/screens/home_screen/main.dart';
import 'package:power_tech/screens/product_screen/main.dart';

void main() async {
  await dotenv.load(fileName: ".env");

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
        "product": (context) => const ProductScreen(),
      },
    );
  }
}
