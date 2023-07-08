import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "dart:developer" as developer;

import 'package:power_tech/models/product_model.dart';
import 'package:power_tech/services/api_services.dart';
import 'package:power_tech/utils/format_to_real.dart';

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
      body: ValueListenableBuilder(
        valueListenable: product,
        builder: (context, value, child) {
          if (value == null) {
            return const CircularProgressIndicator();
          }

          final String formattedPrice = formatToReal(value.price);

          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 30,
                      right: 20,
                      bottom: 20,
                      left: 20,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Tooltip(
                          message: "Sair",
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.black87,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "Detalhes",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Tooltip(
                              message: "Favorito",
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white54,
                                size: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 40,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 18),
                        ),
                      ],
                    ),
                    child: FlutterCarousel.builder(
                      itemCount: value.imageUrlIds.length,
                      options: CarouselOptions(
                        height: double.maxFinite,
                        autoPlay: true,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayInterval: const Duration(
                          seconds: 4,
                        ),
                        showIndicator: true,
                        slideIndicator: const CircularSlideIndicator(),
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Image.network(
                          "${dotenv.env["IMAGE_URL"]}/${value.imageUrlIds[index]}.jpg",
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                value.name,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              formattedPrice,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          value.description,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
