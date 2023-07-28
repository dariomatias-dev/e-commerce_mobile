import 'package:flutter/material.dart';
import 'package:power_tech/widgets/custom_app_bar_widget/open_drawer_button_widget.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({
    super.key,
    required this.title,
    required this.actionIcon,
    required this.actionIconTooltip,
    required this.actionIconFunction,
    required this.scaffoldKey,
  });

  final String title;
  final IconData actionIcon;
  final String actionIconTooltip;
  final VoidCallback actionIconFunction;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 56,
      leading: OpenDrawerButtonWidget(
        scaffoldKey: scaffoldKey,
      ),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        GestureDetector(
          onTap: actionIconFunction,
          child: Tooltip(
            message: actionIconTooltip,
            child: Icon(
              actionIcon,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 6),
      ],
    );
  }
}
