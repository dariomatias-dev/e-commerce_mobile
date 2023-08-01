import 'package:flutter/material.dart';

class PowerTechTextStyles {
  PowerTechTextStyles._();

  static TextStyle appBarTitle = const TextStyle(
    color: Colors.black,
    fontSize: 14,
  );

  static TextStyle appBarTitleBold = appBarTitle.copyWith(
    fontWeight: FontWeight.w600,
  );
}
