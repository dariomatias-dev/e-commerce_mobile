import 'package:flutter/material.dart';

import 'package:power_tech/core/power_tech_text_styles.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Tooltip(
                      message: "Sair",
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Notificações",
                    style: PowerTechTextStyles.appBarTitleBold,
                  ),
                  const SizedBox(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
