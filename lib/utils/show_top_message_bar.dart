import 'package:flutter/material.dart';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

void showTopMessageBar(BuildContext context) {
  CherryToast.success(
    title: const Text(
      'Produto adicionado a lista de desejos',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
    animationType: AnimationType.fromTop,
    displayCloseButton: false,
    toastDuration: const Duration(milliseconds: 2000),
  ).show(context);
}
