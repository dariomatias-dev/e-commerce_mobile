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
        top: 30,
      ),
      child: FlutterCarousel.builder(
        itemCount: imageUrlIds.length,
        options: CarouselOptions(
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(
            seconds: 1,
          ),
          autoPlayInterval: const Duration(
            seconds: 4,
          ),
          indicatorMargin: 1,
          showIndicator: true,
          slideIndicator: CircularStaticIndicator(
            currentIndicatorColor: Colors.black,
            indicatorBackgroundColor: Colors.black.withOpacity(0.1),
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
