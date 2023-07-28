import 'package:flutter/material.dart';

import 'package:power_tech/screens/cart_screen/components/card_product_widget/main.dart';
import 'package:power_tech/screens/main_screen/components/drawer_widget/main.dart';

import 'package:power_tech/widgets/app_bar_break_widget.dart';
import 'package:power_tech/widgets/custom_app_bar_widget/main.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(
        title: "Carrinho",
        actionIcon: Icons.remove_circle_outline,
        actionIconTooltip: "Remover tudo",
        actionIconFunction: () {},
        scaffoldKey: _scaffoldKey,
      ),
      body: const Column(
        children: [
          AppBarBreakWidget(),
          CartProductCardWidget(),
        ],
      ),
      drawer: const DrawerWidget(),
    );
  }
}
