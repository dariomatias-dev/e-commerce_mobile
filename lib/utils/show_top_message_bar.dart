import 'package:flutter/material.dart';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

Map<String, dynamic> messages = {
  "cart": {
    "added": "Produto adicionado ao carrinho.",
    "removed": "Produto removido do carrinho.",
  },
  "wishlist": {
    "added": "Produto adicionado a lista de desejos.",
    "removed": "Produto removido da lista de desejos.",
  },
};

void showTopMessageBar(BuildContext context, String listType, String actionType) {
  CherryToast.success(
    title: Text(
      messages[listType][actionType],
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
    animationType: AnimationType.fromTop,
    displayCloseButton: false,
    toastDuration: const Duration(milliseconds: 2000),
  ).show(context);
}
