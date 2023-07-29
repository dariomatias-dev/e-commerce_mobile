import 'package:flutter/material.dart';

import 'package:power_tech/providers/user_preferences_inherited.dart';

import 'package:power_tech/screens/main_screen/components/drawer_widget/main.dart';

import 'package:power_tech/widgets/custom_app_bar_widget/main.dart';
import 'package:power_tech/widgets/feedback_widget.dart';
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
      body: FutureBuilder(
        future: Future.value(
          UserPreferencesInherited.of(context)?.wishlistProductIds,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const FeedbackWidget(
              message: "Ocorreu um problema",
            );
          }

          List<String>? wishlistProductIds = snapshot.data;

          if (wishlistProductIds != null && wishlistProductIds.isEmpty) {
            return const FeedbackWidget(
              message: "Ainda não há produtos na lista de desejos.",
            );
          }

          return ListProductWidget(
            routeName: "products-by-ids",
            wishlistProductIds: wishlistProductIds,
            listType: "wishlist",
            listDirection: "vertical",
          );
        },
      ),
      drawer: const DrawerWidget(),
    );
  }
}
