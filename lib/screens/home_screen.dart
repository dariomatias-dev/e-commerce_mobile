import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:power_tech/widgets/custom_drawer_widget/custom_drawer_widget.dart';

import 'package:power_tech/models/products_card_navigation_model.dart';
import 'package:power_tech/models/product_card_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<ProductsCardNavigation> productsCardNavigation;
  int amountOfProducts = 0;
  bool enableLoadMoreButton = true;

  @override
  void initState() {
    super.initState();
    getAmountOfProducts();
    getProductsData(0);
  }

  Future<void> getAmountOfProducts() async {
    String url = "${dotenv.env["API_URL"]}/products-amount";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      amountOfProducts = jsonDecode(response.body);
    } else {
      throw Exception("Failed fecth data. Status code ${response.statusCode}");
    }
  }

  Future<void> getProductsData(int skip) async {
    productsCardNavigation = Future.value(fetchData(skip));

    late ProductsCardNavigation data;

    await productsCardNavigation.then(
      (value) => data = value,
    );

    setState(() {
      if (data.skip >= amountOfProducts) {
        enableLoadMoreButton = false;
      } else {
        enableLoadMoreButton = true;
      }
    });
  }

  Future<ProductsCardNavigation> fetchData(int skip) async {
    String url = "${dotenv.env["API_URL"]}/products?skip=$skip";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return ProductsCardNavigation.fromMap(data);
    } else {
      throw Exception("Failed fetch data. Status code ${response.statusCode}.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
        future: productsCardNavigation,
        builder: (context, AsyncSnapshot<ProductsCardNavigation> snapshot) {
          if (snapshot.hasData) {
            List<ProductCard> products = snapshot.data!.productsCard;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(products[index].name),
                  subtitle: Text(products[index].price),
                );
              },
            );
          } else if (snapshot.hasError) {
            throw Exception(snapshot.hasError);
          }

          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: [
          FloatingActionButton(
            onPressed: () {
              productsCardNavigation.then((value) {
                getProductsData(value.take);
              });
            },
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor:
                enableLoadMoreButton ? Colors.blue[500] : Colors.black54,
            onPressed: enableLoadMoreButton
                ? () {
                    productsCardNavigation.then((value) {
                      getProductsData(value.skip);
                    });
                  }
                : null,
            child: const Icon(Icons.arrow_forward_sharp),
          ),
        ],
      ),
    );
  }
}
