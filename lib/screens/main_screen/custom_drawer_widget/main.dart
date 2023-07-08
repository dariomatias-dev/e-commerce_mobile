import 'package:flutter/material.dart';

import 'package:power_tech/screens/main_screen/custom_drawer_widget/main_navigation.dart';
import 'package:power_tech/screens/main_screen/custom_drawer_widget/other_options.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/drawer_background.png",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Text(""),
                ),
              ),
              MainNavigation(),
            ],
          ),
          Column(
            children: [
              Divider(),
              OtherOptions(),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
