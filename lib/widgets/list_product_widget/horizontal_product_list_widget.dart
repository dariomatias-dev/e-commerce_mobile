import 'package:flutter/material.dart';

import 'package:power_tech/models/product_card_model.dart';

import 'package:power_tech/widgets/product_card_widget.dart';

class HorizontalProductListWidget extends StatefulWidget {
  const HorizontalProductListWidget({
    super.key,
    required this.productsCard,
    required this.scrollController,
    required this.fetchData,
    required this.conditionToSkip,
  });

  final List<ProductCardModel> productsCard;
  final ScrollController scrollController;
  final Function fetchData;
  final bool conditionToSkip;

  @override
  State<HorizontalProductListWidget> createState() =>
      _HorizontalProductListWidgetState();
}

class _HorizontalProductListWidgetState
    extends State<HorizontalProductListWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final scrollControler = widget.scrollController;

      scrollControler.addListener(() {
        final ScrollPosition scrollPosition = scrollControler.position;
        final bool reachedScrollEnd =
            scrollPosition.pixels == scrollPosition.maxScrollExtent;
        if (reachedScrollEnd && widget.conditionToSkip) {
          widget.fetchData();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsCard = widget.productsCard;

    return SizedBox(
      height: 220,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          bottom: 4,
        ),
        controller: widget.scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: productsCard.length * 2 + 1,
        itemBuilder: (context, index) {
          if (index == 0 || index == productsCard.length + 1) {
            return const SizedBox(width: 6);
          } else if (index % 2 == 0) {
            return const SizedBox(width: 10);
          }

          return ProductCardWidget(
            productCard: productsCard[(index / 2).floor()],
          );
        },
      ),
    );
  }
}
