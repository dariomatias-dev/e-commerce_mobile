import 'package:flutter/material.dart';
import "dart:developer" as developer;
import 'dart:convert';

import 'package:power_tech/models/product_model.dart';

import 'package:power_tech/providers/product_screen_context_inherited.dart';

import 'package:power_tech/screens/product_screen/components/announcement_widget.dart';
import 'package:power_tech/screens/product_screen/components/carousel_images_widget.dart';
import 'package:power_tech/screens/product_screen/components/floating_action_button_widget.dart';
import 'package:power_tech/screens/product_screen/components/header_widget.dart';
import 'package:power_tech/screens/product_screen/components/infos_widget/main.dart';

import 'package:power_tech/widgets/divider_widget.dart';

import 'package:power_tech/services/api_services.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final APIServices apiServices = APIServices();
  final ValueNotifier<ProductModel?> product =
      ValueNotifier<ProductModel?>(null);
  bool thereAreSimilarProducts = true;

  @override
  void initState() {
    super.initState;
    getProduct();
  }

  Future<void> getProduct() async {
    try {
      var response = await apiServices.get("product/${widget.productId}");
      Map<String, dynamic> data = jsonDecode(response);

      product.value = ProductModel.fromMap(data);
    } catch (err) {
      developer.log(
        "An excess occurred: $err",
        error: err,
      );
    }
  }

  void chanceThereAreSimilarProducts(bool value) {
    setState(() {
      thereAreSimilarProducts = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: product,
      builder: (context, value, child) {
        if (value == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final String id = value.id;

        return ProductScreenInfoInherited(
          screenContext: context,
          thereAreSimilarProducts: thereAreSimilarProducts,
          chanceThereAreSimilarProducts: chanceThereAreSimilarProducts,
          child: Scaffold(
            body: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeaderWidget(
                      productId: id,
                    ),
                    CarouselImagesWidget(
                      productName: value.name,
                      amountOfImages: value.amountOfImages,
                    ),
                    InfosWidget(
                      productId: id,
                      name: value.name,
                      price: value.price,
                      description: value.description,
                      categoryIds: value.categoryIds,
                    ),
                    const DividerWidget(),
                    const AnnouncementWidget(),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButtonWidget(
              productId: id,
            ),
          ),
        );
      },
    );
  }
}
