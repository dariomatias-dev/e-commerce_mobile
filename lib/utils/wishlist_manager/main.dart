import "package:flutter/material.dart";
import "dart:developer" as developer;

import "package:power_tech/services/api_services.dart";
import "package:power_tech/utils/show_top_message_bar.dart";

class WishlistManager {
  WishlistManager({
    required this.screenContext,
    required this.productId,
    required this.favorites,
  });

  final BuildContext screenContext;
  final String productId;
  final List<String> favorites;

  void update() {
    List<String> newFavorites = favorites;
    if (favorites.contains(productId)) {
      newFavorites.remove(productId);
    } else {
      newFavorites.add(productId);
    }
    sendNewWishlist(newFavorites);
  }

  Future<void> sendNewWishlist(List<String> newFavorites) async {
    final APIServices apiServices = APIServices();

    final Map<String, dynamic> body = {
      "productIds": newFavorites,
    };
    
    try {
      await apiServices.createData(
        "favorite/f681f544-20ec-11ee-be56-0242ac120002",
        body,
      );
      sendSuccessMessage();
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  void sendSuccessMessage() {
    showTopMessageBar(screenContext);
  }
}
