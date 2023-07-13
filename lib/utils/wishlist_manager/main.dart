import "package:flutter/material.dart";
import "package:power_tech/providers/my_app_favorites_inherited.dart";
import "dart:developer" as developer;

import "package:power_tech/services/api_services.dart";
import 'package:power_tech/utils/wishlist_manager/show_top_message_bar.dart';

class WishlistManager {
  WishlistManager({
    required this.screenContext,
    required this.productId,
    required this.myAppFavoritesInherited,
  });

  final BuildContext screenContext;
  final String productId;
  final MyAppFavoritesInherited myAppFavoritesInherited;

  void update() {
    final List<String> favorites = myAppFavoritesInherited.favorites;
    List<String> newFavorites = favorites;
    late String actionType;
    if (favorites.contains(productId)) {
      newFavorites.remove(productId);
      actionType = "removed";
    } else {
      newFavorites.add(productId);
      actionType = "added";
    }
    sendNewWishlist(
      newFavorites,
      actionType,
    );

    myAppFavoritesInherited.updateFavorites(newFavorites);
  }

  Future<void> sendNewWishlist(List<String> newFavorites, String actionType) async {
    final APIServices apiServices = APIServices();

    final Map<String, dynamic> body = {
      "productIds": newFavorites,
    };

    try {
      await apiServices.createData(
        "favorite/f681f544-20ec-11ee-be56-0242ac120002",
        body,
      );
      sendSuccessMessage(actionType);
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  void sendSuccessMessage(String actionType) {
    showTopMessageBar(
      screenContext,
      "wishlist",
      actionType,
    );
  }
}
