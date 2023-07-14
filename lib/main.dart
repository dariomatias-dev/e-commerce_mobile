import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;
import 'dart:convert';

import 'package:power_tech/providers/user_preferences_inherited.dart';

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
  List<String>? favoriteProducts;
  List<String>? cartProducts;

  @override
  void initState() {
    super.initState();
    fetchFavoriteProducts();
    fetchCartProducts();
  }

  Future<void> fetchFavoriteProducts() async {
    try {
      var response = await apiServices.fetchData(
        "wishlist/f681f544-20ec-11ee-be56-0242ac120002",
      );

      if (jsonDecode(response) != null) {
        favoriteProducts =
            (jsonDecode(response) as List<dynamic>).cast<String>();
      }
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  Future<void> fetchCartProducts() async {
    try {
      var response = await apiServices.fetchData(
        "cart/f681f544-20ec-11ee-be56-0242ac120002",
      );

      if (jsonDecode(response) != null) {
        cartProducts = (jsonDecode(response) as List<dynamic>).cast<String>();
      }
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  void updateFavoriteProducts(List<String> newFavoriteProducts) {
    favoriteProducts = newFavoriteProducts;
  }

  void updateCartProducts(List<String> newCartProducts) {
    cartProducts = newCartProducts;
  }

  @override
  Widget build(BuildContext context) {
    return UserPreferencesInherited(
      favoriteProducts: favoriteProducts ?? [],
      updateFavoriteProducts: updateFavoriteProducts,
      cartProducts: cartProducts ?? [],
      updateCartProducts: updateCartProducts,
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
