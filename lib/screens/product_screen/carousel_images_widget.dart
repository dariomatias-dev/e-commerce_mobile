import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class CarouselImagesWidget extends StatelessWidget {
  const CarouselImagesWidget({super.key, required this.imageUrlIds});

  final List<String> imageUrlIds;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        itemCount: imageUrlIds.length,
        options: CarouselOptions(
          height: double.maxFinite,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(
            seconds: 1,
          ),
          autoPlayInterval: const Duration(
            seconds: 4,
          ),
          showIndicator: true,
          indicatorMargin: 1,
          slideIndicator: CircularStaticIndicator(
            currentIndicatorColor: Colors.black,
          ),
        ),
        itemBuilder: (context, index, realIndex) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 30,
            ),
            child: Image.network(
              "${dotenv.env["IMAGE_URL"]}/${imageUrlIds[index]}.jpg",
            ),
          );
        },
      ),
    );
  }
}
