import 'package:flutter/material.dart';

import 'package:power_tech/screens/cart_screen/components/card_product_widget/main.dart';
import 'package:power_tech/screens/main_screen/components/drawer_widget/main.dart';

import 'package:power_tech/widgets/app_bar_break_widget.dart';
import 'package:power_tech/widgets/open_drawer_button_widget.dart';

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
      appBar: AppBar(
        elevation: 0,
        leading: OpenDrawerButtonWidget(
          scaffoldKey: _scaffoldKey,
        ),
        centerTitle: true,
        title: const Text(
          "Carrinho",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            child: const Tooltip(
              message: "Remover tudo",
              child: Icon(
                Icons.remove_circle_outline,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
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
