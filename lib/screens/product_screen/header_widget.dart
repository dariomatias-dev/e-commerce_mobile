import 'package:neumorphic_ui/neumorphic_ui.dart';

import 'package:power_tech/providers/product_screen_context_inherited.dart';

import 'package:power_tech/managers/user_preferences_manager.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.productId});

  final String productId;

  void updateUserPreferences(
    String productId,
    BuildContext context,
    BuildContext screenContext,
  ) {
    final UserPreferencesManager userPreferencesManager = UserPreferencesManager(
      listType: "wishlist",
      productId: productId,
      screenContext: screenContext,
      context: context,
    );
    userPreferencesManager.update();
  }

  @override
  Widget build(BuildContext context) {
    final BuildContext screenContext = ProductScreenContextInherited.of(context)!.screenContext;

    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        right: 12,
        bottom: 10,
        left: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(
              message: "Sair",
              child: NeumorphicButton(
                padding: const EdgeInsets.all(5.5),
                style: NeumorphicStyle(
                  color: Colors.grey.shade200.withOpacity(0.5),
                  shape: NeumorphicShape.flat,
                  boxShape: const NeumorphicBoxShape.circle(),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: NeumorphicIcon(
                  Icons.arrow_back_rounded,
                  size: 20,
                  style: const NeumorphicStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const Text(
            "Detalhes",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => updateUserPreferences(
                productId,
                context,
                screenContext,
              ),
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Tooltip(
                  message: "Favorito",
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white54,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
