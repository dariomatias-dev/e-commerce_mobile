import 'package:flutter/material.dart';
import "dart:developer" as developer;

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    initFecths();
  }

  Future<void> initFecths() async {
    await fetchAmount();
    fetchData();
  }

  Future<void> fetchAmount() async {
    try {} catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  Future<void> fetchData() async {
    try {} catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
