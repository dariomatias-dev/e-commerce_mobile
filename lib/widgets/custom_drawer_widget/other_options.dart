import 'package:flutter/material.dart';

class OtherOptions extends StatelessWidget {
  const OtherOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.share),
          title: const Text("Compartilhar"),
          onTap: () {
            Navigator.pushNamed(context, "");
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text("Quem somos"),
          onTap: () {
            Navigator.pushNamed(context, "");
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: () {
            Navigator.pushNamed(context, "");
          },
        ),
      ],
    );
  }
}
