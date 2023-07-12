import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomNavigationBarMainWidget extends StatefulWidget {
  const BottomNavigationBarMainWidget({super.key, required this.onTabSelector});

  final Function(int) onTabSelector;

  @override
  State<BottomNavigationBarMainWidget> createState() =>
      _BottomNavigationBarMainStateWidget();
}

class _BottomNavigationBarMainStateWidget
    extends State<BottomNavigationBarMainWidget> {
  final List<IconData> _icons = [
    Icons.home,
    Icons.favorite_border,
    Icons.shopping_cart,
    Icons.settings,
  ];

  int _selectedTab = 0;

  void _setTab(int index) {
    setState(() {
      _selectedTab = index;
    });
    widget.onTabSelector(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_icons.length, (index) {
          return CupertinoButton(
            onPressed: () {
              _setTab(index);
            },
            child: AnimatedOpacity(
              opacity: _selectedTab == index ? 1 : 0.5,
              duration: const Duration(
                milliseconds: 200,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -4,
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 200,
                      ),
                      width: _selectedTab == index ? 20 : 0,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: Icon(
                      _icons[index],
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
