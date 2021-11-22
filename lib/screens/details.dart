import 'package:flutter/material.dart';
import 'package:mealmagic/models/products.dart';
import 'package:mealmagic/providers/app.dart';
import 'package:mealmagic/providers/user.dart';
import 'package:mealmagic/services/screen_navigation.dart';
import 'package:mealmagic/services/style.dart';
import 'package:mealmagic/widgets/custom_text.dart';
import 'package:mealmagic/widgets/loading.dart';
import 'package:provider/provider.dart';

import '../services/style.dart';
import 'cart.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({Key? key, required this.product}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              changeScreen(context, const CartScreen());
            },
          ),
        ],
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: app.isLoading ? Loading() : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                  CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage(widget.product.image),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: widget.product.name,
                    size: 26,
                    weight: FontWeight.bold,
                    color: black,
                  ),
                  CustomText(
                    text: "Ksh${widget.product.price}",
                    size: 20,
                    weight: FontWeight.w400,
                    color: black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: const Icon(
                              Icons.remove,
                              size: 36,
                            ),
                            onPressed: () {
                              if (quantity != 1) {
                                setState(() {
                                  quantity -= 1;
                                });
                              }
                            }),
                ),

                GestureDetector(
                  onTap: ()async{
                    app.changeLoading();
                    bool value =  await user.addToCard(product: widget.product, quantity: quantity);
                    if(value) {
                            const snackBar =
                                SnackBar(content: Text("Added to cart"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            user.reloadUserModel();
                            app.changeLoading();
                            return;
                          } else {
                            const snackBar =
                                SnackBar(content: Text("Not added to cart"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                  child: Container(
                    decoration: BoxDecoration(
                              color: const Color(0xfff47a5a),
                              borderRadius: BorderRadius.circular(10)),
                    child: app.isLoading ? Loading() : Padding(
                      padding: const EdgeInsets.fromLTRB(28,12,28,12),
                      child: CustomText(text: "Add $quantity To Cart",color: white,size: 22,weight: FontWeight.w300,),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 36,
                              color: Color(0xfff47a5a),
                            ),
                            onPressed: () {
                              setState(() {
                                quantity += 1;
                              });
                            }),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
