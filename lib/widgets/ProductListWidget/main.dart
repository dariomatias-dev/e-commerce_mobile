import 'package:flutter/material.dart';
import 'dart:convert';
import "dart:developer" as developer;

import 'package:power_tech/services/api_services.dart';

import 'package:power_tech/models/products_card_navigation_model.dart';
import 'package:power_tech/models/product_card_model.dart';

import 'package:power_tech/widgets/ProductListWidget/products_widget.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({
    super.key,
    required this.routeName,
    this.productId,
    this.categoryIds,
  });

  final String routeName;
  final String? productId;
  final String? categoryIds;

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  final APIServices apiServices = APIServices();
  final ValueNotifier<ProductsCardNavigationModel?> productsCardNavigation =
      ValueNotifier<ProductsCardNavigationModel?>(null);
  int amountOfProducts = 0;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initFetchs();
  }

  Future<void> initFetchs() async {
    await fetchQuantityProducts();
    fetchData(0);
  }

  Future<void> fetchQuantityProducts() async {
    try {
      final String categoryIdsParam = widget.productId != null
          ? "?productId=${widget.productId}&categoryIds=${widget.categoryIds}"
          : "";
      final String url = "${widget.routeName}/amount$categoryIdsParam";
      var result = await apiServices.fetchData(url);
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
      final String categoryIdsParam = widget.productId != null
          ? "&productId=${widget.productId}&categoryIds=${widget.categoryIds}"
          : "";
      final String url = "${widget.routeName}?skip=$skip$categoryIdsParam";
      var result = await apiServices.fetchData(url);
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

      setState(() {
        productsCardNavigation.value = newProductsCardNavigation;
      });
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
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
        }

        return ProductsWidget(
          productsCard: value.productsCard,
          scrollController: scrollController,
          fetchData: loadMoreProducts,
          conditionToSkip: value.skip - 10 < amountOfProducts,
        );
      },
    );
  }
}
