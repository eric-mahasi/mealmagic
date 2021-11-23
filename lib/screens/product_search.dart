import 'package:flutter/material.dart';
import 'package:mealmagic/providers/product.dart';
import 'package:mealmagic/services/screen_navigation.dart';
import 'package:mealmagic/services/style.dart';
import 'package:mealmagic/widgets/custom_text.dart';
import 'package:mealmagic/widgets/product.dart';
import 'package:provider/provider.dart';

import 'details.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: const CustomText(
          text: "Products",
          size: 20,
          color: black,
          weight: FontWeight.normal,
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: productProvider.productsSearched.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.search,
                      color: grey,
                      size: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CustomText(
                      text: "No products Found",
                      color: grey,
                      weight: FontWeight.w300,
                      size: 22,
                    ),
                  ],
                )
              ],
            )
          : ListView.builder(
              itemCount: productProvider.productsSearched.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async {
                      changeScreen(
                          context,
                          Details(
                              product:
                                  productProvider.productsSearched[index]));
                    },
                    child: ProductWidget(
                        product: productProvider.productsSearched[index]));
              }),
    );
  }
}
