import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:carousel_slider/carousel_slider.dart';

class CarouselImagesWidget extends StatefulWidget {
  const CarouselImagesWidget({super.key, required this.imageUrlIds});

  final List<String> imageUrlIds;

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
    final imageUrlIds = widget.imageUrlIds;

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
            itemCount: imageUrlIds.length,
            itemBuilder: (context, index, realIndex) {
              return Image.network(
                "${dotenv.env["IMAGE_URL"]}/${imageUrlIds[index]}.jpg",
              );
            },
          ),
          const SizedBox(height: 20),
          DotsIndicator(
            dotsCount: imageUrlIds.length,
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
