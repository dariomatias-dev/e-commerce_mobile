import 'package:flutter/material.dart';

import 'package:power_tech/screens/main_screen/components/drawer_widget/main.dart';

import 'package:power_tech/widgets/custom_app_bar_widget/main.dart';
import 'package:power_tech/widgets/list_product_widget/main.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(
        title: "Lista de desejos",
        actionIcon: Icons.search,
        actionIconTooltip: "Pesquisar",
        actionIconFunction: () {},
        scaffoldKey: _scaffoldKey,
      ),
      body: const ListProductWidget(
        routeName: "products-by-ids",
        listType: "wishlist",
        listDirection: "vertical",
      ),
      drawer: const DrawerWidget(),
    );
  }
}
