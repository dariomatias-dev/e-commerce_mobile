import 'package:flutter/material.dart';
import 'dart:convert';
import "dart:developer" as developer;

import 'package:power_tech/models/products_card_navigation_model.dart';
import 'package:power_tech/models/product_card_model.dart';

import 'package:power_tech/providers/product_screen_context_inherited.dart';
import 'package:power_tech/providers/user_preferences_inherited.dart';

import 'package:power_tech/widgets/list_product_widget/horizontal_product_list_widget.dart';
import 'package:power_tech/widgets/list_product_widget/vertical_product_list_widget.dart.dart';

import 'package:power_tech/services/api_services.dart';

class ListProductWidget extends StatefulWidget {
  const ListProductWidget({
    super.key,
    required this.routeName,
    this.productId,
    this.categoryIds,
    required this.listType,
    required this.listDirection,
  });

  final String routeName;
  final String? productId;
  final List<String>? categoryIds;
  final String listType;
  final String listDirection;

  @override
  State<ListProductWidget> createState() => _ListProductWidgetState();
}

class _ListProductWidgetState extends State<ListProductWidget> {
  final APIServices apiServices = APIServices();
  final ValueNotifier<ProductsCardNavigationModel?> productsCardNavigation =
      ValueNotifier<ProductsCardNavigationModel?>(null);
  int amountOfProducts = 0;

  final ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initFetchs();
  }

  Future<void> initFetchs() async {
    await fetchQuantityProducts();
    fetchData(0);
  }

  Future<void> fetchQuantityProducts() async {
    try {
      final String categoryIdsParam =
          widget.categoryIds != null ? setUrlParams() : "";
      final String url = setUrl(categoryIdsParam, true, null);

      var result = await apiServices.get(url);
      amountOfProducts = int.parse(result);
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  Future<void> fetchData(int skip) async {
    try {
      final String categoryIdsParam = setUrlParams();
      final String url = setUrl(categoryIdsParam, false, skip);

      var result = await apiServices.get(url);
      Map<String, dynamic> data = jsonDecode(result);

      final ProductsCardNavigationModel productsCardNavigationData =
          ProductsCardNavigationModel.fromMap(data);

      late final List<ProductCardModel> productsCard;

      if (productsCardNavigation.value == null) {
        productsCard = productsCardNavigationData.productsCard;
      } else {
        productsCard = [
          ...productsCardNavigation.value!.productsCard,
          ...productsCardNavigationData.productsCard
        ];
      }

      final ProductsCardNavigationModel newProductsCardNavigation =
          ProductsCardNavigationModel(
        skip: productsCardNavigationData.skip,
        take: productsCardNavigationData.take,
        productsCard: productsCard,
      );

      final bool thereAreSimilarProducts =
          newProductsCardNavigation.productsCard.isNotEmpty;
      updateThereAreSimilarProducts(thereAreSimilarProducts);

      if (thereAreSimilarProducts) {
        setState(() {
          productsCardNavigation.value = newProductsCardNavigation;
        });
      }
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  // Will define the parameters of the URL
  String setUrlParams() {
    final String params = widget.productId != null
        ? "?productId=${widget.productId}&categoryIds=${widget.categoryIds!.join(",")}&"
        : "?";

    return params;
  }

  // Will define the URL that will be used based on the parameters passed to the ListProductWidget and to the function.
  String setUrl(String categoryIdsParam, bool fetchQuantity, int? skip) {
    late String url;
    final commonPartUrl =
        "${widget.routeName}${fetchQuantity ? "/amount" : ""}";

    if (widget.listType == "wishlist") {
      final List<String>? productIds =
          UserPreferencesInherited.of(context)?.wishlistProductIds;

      url =
          "$commonPartUrl?${skip != null ? "skip=$skip&" : ""}productIds=${productIds!.join(",")}";
    } else {
      url =
          "$commonPartUrl$categoryIdsParam${skip != null ? "skip=$skip" : ""}";
    }

    return url;
  }

  void updateThereAreSimilarProducts(bool thereAreSimilarProducts) {
    ProductScreenInfoInherited.of(context)
        ?.chanceThereAreSimilarProducts(thereAreSimilarProducts);
  }

  void loadMoreProducts() {
    fetchData(productsCardNavigation.value!.skip);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: productsCardNavigation,
      builder: (context, value, child) {
        if (value == null) {
          return const CircularProgressIndicator();
        } else if (value.productsCard.isEmpty) {
          return const Center(
            child: Text(
              "Não há produtos.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        if (widget.listDirection == "horizontal") {
          return HorizontalProductListWidget(
            productsCard: value.productsCard,
            scrollController: scrollController,
            fetchData: loadMoreProducts,
            conditionToSkip: value.skip < amountOfProducts,
          );
        }

        return VerticalProductListWidget(
          productsCard: value.productsCard,
          scrollController: scrollController,
          fetchData: loadMoreProducts,
          conditionToSkip: value.skip < amountOfProducts,
        );
      },
    );
  }
}
