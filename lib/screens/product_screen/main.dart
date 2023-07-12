import 'package:flutter/material.dart';
import "dart:developer" as developer;
import 'dart:convert';

import 'package:power_tech/models/product_model.dart';

import 'package:power_tech/providers/product_screen_context_inherited.dart';

import 'package:power_tech/screens/product_screen/header_widget.dart';
import 'package:power_tech/screens/product_screen/carousel_images_widget.dart';
import 'package:power_tech/screens/product_screen/details_widget/main.dart';
import 'package:power_tech/screens/product_screen/bottomnavigationbar_product_widget.dart';

import 'package:power_tech/services/api_services.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final APIServices apiServices = APIServices();
  late final ValueNotifier<ProductModel?> product =
      ValueNotifier<ProductModel?>(null);

  @override
  void initState() {
    super.initState;
    getProduct();
  }

  Future<void> getProduct() async {
    try {
      var response = await apiServices.fetchData("product/${widget.productId}");
      Map<String, dynamic> data = jsonDecode(response);

      product.value = ProductModel.fromMap(data);
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductScreenContextInherited(
        screenContext: context,
        child: ValueListenableBuilder(
          valueListenable: product,
          builder: (context, value, child) {
            if (value == null) {
              return const CircularProgressIndicator();
            }

            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const HeaderWidget(),
                    CarouselImagesWidget(
                      imageUrlIds: value.imageUrlIds,
                    ),
                    DetailsWidget(
                      productId: value.id,
                      name: value.name,
                      price: value.price,
                      description: value.description,
                      categoryIds: value.categoryIds,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarProductWidget(),
    );
  }
}
