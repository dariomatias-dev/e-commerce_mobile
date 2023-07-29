import 'package:flutter/material.dart';

import 'package:power_tech/models/product_card_model.dart';

import 'package:power_tech/widgets/app_bar_break_widget.dart';
import 'package:power_tech/widgets/product_card_widget.dart';

class VerticalProductListWidget extends StatefulWidget {
  const VerticalProductListWidget({
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
  State<VerticalProductListWidget> createState() =>
      _VerticalProductListWidgetState();
}

class _VerticalProductListWidgetState extends State<VerticalProductListWidget> {
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

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false,
      ),
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          children: [
            const AppBarBreakWidget(),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 10,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.spaceBetween,
                      children: List.generate(
                        productsCard.length,
                        (index) {
                          final ProductCardModel productCard =
                              productsCard[index];

                          return ProductCardWidget(
                            productCard: productCard,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
