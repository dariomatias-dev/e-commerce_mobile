import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;
import 'dart:convert';

import 'package:power_tech/providers/user_preferences_inherited.dart';

import 'package:power_tech/screens/main_screen/main.dart';
import 'package:power_tech/screens/notifications_screen/main.dart';
import 'package:power_tech/screens/search_screen/main.dart';

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

  Future<void> fetchWishlistProductIds() async {
    try {
      var response = await apiServices.get(
        "wishlist/57e99e52-753e-4da7-8a67-a6286edd2ee4",
      );

      setState(() {
        wishlistProductIds =
            (jsonDecode(response) as List<dynamic>).cast<String>();
      });
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
        "cart/57e99e52-753e-4da7-8a67-a6286edd2ee4",
      );
      setState(() {
        cartProductIds = (jsonDecode(response) as List<dynamic>).cast<String>();
      });
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  void updateWishlistProductIds(List<String> newWishlistProductIds) {
    setState(() {
      wishlistProductIds = newWishlistProductIds;
    });
  }

  void updateCartProductIds(List<String> newCartProductIds) {
    setState(() {
      cartProductIds = newCartProductIds;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWishlistProductIds();
    fetchCartProductIds();
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
          canvasColor: Colors.white,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const MainScreen(),
          "notifications": (context) => const NotificationsScreen(),
          "search": (context) => const SearchScreen(),
        },
      ),
    );
  }
}
