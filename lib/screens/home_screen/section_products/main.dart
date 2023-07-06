import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'dart:convert';

import 'package:power_tech/models/products_card_navigation_model.dart';
import 'package:power_tech/screens/home_screen/section_products/product_card_widget.dart';

import 'package:power_tech/services/api_services.dart';

class SectionProducts extends StatefulWidget {
  const SectionProducts({super.key});

  @override
  State<SectionProducts> createState() => _SectionProductsState();
}

class _SectionProductsState extends State<SectionProducts> {
  APIServices apiServices = APIServices();
  final ValueNotifier<ProductsCardNavigation?> productsCardNavigation =
      ValueNotifier<ProductsCardNavigation?>(null);
  int amountOfProducts = 0;
  bool enableLoadMoreButton = true;

  @override
  void initState() {
    super.initState();
    fetchDatas();
  }

  Future<void> fetchDatas() async {
    await getAmountOfProducts();
    fetchData(0);
  }

  Future<void> getAmountOfProducts() async {
    try {
      var data = await apiServices.fetchData("products-amount");
      amountOfProducts = jsonDecode(data);
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  Future<void> fetchData(int skip) async {
    try {
      var result = await apiServices.fetchData("products?skip=$skip");
      Map<String, dynamic> data = jsonDecode(result);

      ProductsCardNavigation productsCardNavigationData =
          ProductsCardNavigation.fromMap(data);
      setState(() {
        productsCardNavigation.value = productsCardNavigationData;
        enableLoadMoreButton =
            !(productsCardNavigationData.skip >= amountOfProducts);
      });
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
      throw Exception("Failed to fetch data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: productsCardNavigation,
      builder: (context, value, child) {
        if (value == null) {
          return const CircularProgressIndicator();
        }

        return Container(
          height: 250,
          margin: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: value.productsCard.length + 1,
            itemBuilder: (context, index) {
              if (index == 0 || index == value.productsCard.length + 1) {
                return const SizedBox(width: 2);
              }

              return ProductCardWidget(
                productCard: value.productsCard[index - 1],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
          ),
        );
      },
    );
  }
}