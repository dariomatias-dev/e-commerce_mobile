import 'package:flutter/material.dart';
import "dart:developer" as developer;
import 'dart:convert';

import 'package:power_tech/models/products_card_navigation_model.dart';

import 'package:power_tech/services/api_services.dart';

import 'package:power_tech/widgets/custom_drawer_widget/main.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

      productsCardNavigation.value = productsCardNavigationData;
      setState(() {
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
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(),
      body: ValueListenableBuilder(
        valueListenable: productsCardNavigation,
        builder: (context, value, child) {
          if (value == null) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: value.productsCard.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(value.productsCard[index].name),
                  subtitle: Text(value.productsCard[index].price),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: [
          FloatingActionButton(
            onPressed: () {
              fetchData(productsCardNavigation.value?.take ?? 0);
            },
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor:
                enableLoadMoreButton ? Colors.blue[500] : Colors.black54,
            onPressed: enableLoadMoreButton
                ? () => fetchData(productsCardNavigation.value?.skip ?? 0)
                : null,
            child: const Icon(Icons.arrow_forward_sharp),
          ),
        ],
      ),
    );
  }
}
