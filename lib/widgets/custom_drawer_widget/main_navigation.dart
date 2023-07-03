import 'package:flutter/material.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.category),
          title: const Text("Departamentos"),
          onTap: () {
            Navigator.pushNamed(context, "");
          },
        ),
        ListTile(
          leading: const Icon(Icons.build),
          title: const Text("Monte o seu PC"),
          onTap: () {
            Navigator.pushNamed(context, "");
          },
        ),
        ListTile(
          leading: const Icon(Icons.new_releases),
          title: const Text("Lançamentos"),
          onTap: () {
            Navigator.pushNamed(context, "");
          },
        ),
        ListTile(
          leading: const Icon(Icons.local_offer),
          title: const Text("Promoções"),
          onTap: () {
            Navigator.pushNamed(context, "");
          },
        ),
        ListTile(
          leading: const Icon(Icons.home_work),
          title: const Text("Home Office"),
          onTap: () {
            Navigator.pushNamed(context, "");
          },
        ),
        ListTile(
          leading: const Icon(Icons.sports_esports),
          title: const Text("PC Gamer"),
          onTap: () {
            Navigator.pushNamed(context, "");
          },
        ),
      ],
    );
  }
}
