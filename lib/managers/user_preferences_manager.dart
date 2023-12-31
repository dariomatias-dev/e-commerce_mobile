import "package:flutter/material.dart";
import "dart:developer" as developer;

import 'package:power_tech/providers/user_preferences_inherited.dart';

import "package:power_tech/services/api_services.dart";

import 'package:power_tech/utils/show_top_message_bar.dart';

class UserPreferencesManager {
  UserPreferencesManager({
    required this.listType,
    required this.productId,
    required this.context,
    this.screenContext,
  });

  final String listType;
  final String productId;
  final BuildContext context;
  final BuildContext? screenContext;

  void update() {
    final UserPreferencesInherited userPreferencesInherited =
        UserPreferencesInherited.of(context)!;
    late String actionType;

    List<String> productIds = listType == "wishlist"
        ? userPreferencesInherited.wishlistProductIds
        : userPreferencesInherited.cartProductIds;

    if (productIds.contains(productId)) {
      productIds.remove(productId);
      actionType = "removed";
    } else {
      productIds.add(productId);
      actionType = "added";
    }

    listType == "wishlist"
        ? userPreferencesInherited.updateWishlistProductIds(productIds)
        : userPreferencesInherited.updateCartProductIds(productIds);

    sendNewProductIds(
      productIds,
      actionType,
    );
  }

  Future<void> sendNewProductIds(
    List<String> productIds,
    String actionType,
  ) async {
    final APIServices apiServices = APIServices();

    final Map<String, dynamic> body = {
      "productIds": productIds,
    };

    try {
      await apiServices.put(
        "$listType/57e99e52-753e-4da7-8a67-a6286edd2ee4",
        body,
      );

      if (screenContext != null) {
        sendSuccessMessage(actionType);
      }
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  void sendSuccessMessage(String actionType) {
    showTopMessageBar(
      screenContext!,
      listType,
      actionType,
    );
  }
}
