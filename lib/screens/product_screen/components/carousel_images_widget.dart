import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:power_tech/utils/format_string.dart';

class CarouselImagesWidget extends StatefulWidget {
  const CarouselImagesWidget({
    super.key,
    required this.productName,
    required this.amountOfImages,
  });

  final String productName;
  final int amountOfImages;

  @override
  State<CarouselImagesWidget> createState() => _CarouselImagesWidgetState();
}

class _CarouselImagesWidgetState extends State<CarouselImagesWidget> {
  int _imageIndexCurrent = 0;

  void _changeImageIndexCurrent(int index) {
    setState(() {
      _imageIndexCurrent = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int amountOfImages = widget.amountOfImages;
    final String formattedProductName = formatString(widget.productName);

    return Container(
      height: 300,
      padding: const EdgeInsets.only(
        top: 30,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              enlargeFactor: 0.5,
              initialPage: 0,
              onPageChanged: (index, reason) {
                _changeImageIndexCurrent(index);
              },
            ),
            itemCount: amountOfImages,
            itemBuilder: (context, index, realIndex) {
              return Image.network(
                "${dotenv.env["PRODUCT_IMAGES_BASE_URL"]}/$formattedProductName/${formattedProductName}_${index + 1}.png",
              );
            },
          ),
          const SizedBox(height: 20),
          DotsIndicator(
            dotsCount: amountOfImages,
            position: _imageIndexCurrent,
            decorator: DotsDecorator(
              activeColor: Colors.black,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
