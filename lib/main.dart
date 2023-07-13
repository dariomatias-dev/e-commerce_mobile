import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;
import 'dart:convert';

import 'package:power_tech/providers/my_app_favorites_inherited.dart';

import 'package:power_tech/screens/main_screen/main.dart';

import 'package:power_tech/services/api_services.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final APIServices apiServices = APIServices();
  List<String>? favorites;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var response = await apiServices
          .fetchData("favorites/f681f544-20ec-11ee-be56-0242ac120002");
      favorites = (jsonDecode(response) as List<dynamic>).cast<String>();
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  void updateFavorites(List<String> newFavorites) {
    favorites = newFavorites;
  }

  @override
  Widget build(BuildContext context) {
    return MyAppFavoritesInherited(
      favorites: favorites ?? [],
      updateFavorites: updateFavorites,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Power Tech App",
        theme: ThemeData(
          canvasColor: const Color.fromARGB(255, 250, 250, 250),
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const MainScreen(),
        },
      ),
    );
  }
}
