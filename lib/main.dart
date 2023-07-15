import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;
import 'dart:convert';

import 'package:power_tech/providers/user_preferences_inherited.dart';

import 'package:power_tech/screens/cart_screen/main.dart';
import 'package:power_tech/screens/main_screen/main.dart';
import 'package:power_tech/screens/wishlist_screen/main.dart';

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
  List<String>? wishlistProductIds;
  List<String>? cartProductIds;

  @override
  void initState() {
    super.initState();
    fetchWishlistProductIds();
    fetchCartProductIds();
  }

  Future<void> fetchWishlistProductIds() async {
    try {
      var response = await apiServices.get(
        "wishlist/f681f544-20ec-11ee-be56-0242ac120002",
      );

      if (jsonDecode(response) != null) {
        wishlistProductIds =
            (jsonDecode(response) as List<dynamic>).cast<String>();
      }
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  Future<void> fetchCartProductIds() async {
    try {
      var response = await apiServices.get(
        "cart/f681f544-20ec-11ee-be56-0242ac120002",
      );

      if (jsonDecode(response) != null) {
        cartProductIds = (jsonDecode(response) as List<dynamic>).cast<String>();
      }
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  void updateWishlistProductIds(List<String> newFavoriteProducts) {
    wishlistProductIds = newFavoriteProducts;
  }

  void updateCartProductIds(List<String> newCartProductIds) {
    cartProductIds = newCartProductIds;
  }

  @override
  Widget build(BuildContext context) {
    return UserPreferencesInherited(
      wishlistProductIds: wishlistProductIds ?? [],
      updateWishlistProductIds: updateWishlistProductIds,
      cartProductIds: cartProductIds ?? [],
      updateCartProductIds: updateCartProductIds,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Power Tech App",
        theme: ThemeData(
          canvasColor: const Color.fromARGB(255, 250, 250, 250),
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const MainScreen(),
          "wishlistScreen": (context) => const WishlistScreen(),
          "cartScreen": (context) => const CartScreen(),
        },
      ),
    );
  }
}
