import 'package:flutter/material.dart';
import 'package:mealmagic/models/cart_item.dart';
import 'package:mealmagic/providers/app.dart';
import 'package:mealmagic/providers/user.dart';
import 'package:mealmagic/services/order.dart';
import 'package:mealmagic/services/style.dart';
import 'package:mealmagic/widgets/custom_text.dart';
import 'package:mealmagic/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  final OrderServices _orderServices = OrderServices();

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
        title: const Text(
          "Cart Items",
          style: TextStyle(
              color: Color(0xFF3a3737),
              fontWeight: FontWeight.w600,
              fontSize: 18),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Loading()
          : ListView.builder(
              itemCount: user.userModel.cart.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xfff47a5a).withOpacity(0.2),
                              offset: const Offset(3, 2),
                              blurRadius: 30)
                        ]),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          child: Image.network(
                            user.userModel.cart[index].image,
                            height: 120,
                            width: 140,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: user.userModel.cart[index].name +
                                          "\n",
                                      style: const TextStyle(
                                          color: black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          "Ksh${user.userModel.cart[index].price} \n\n",
                                      style: const TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300)),
                                  const TextSpan(
                                      text: "Quantity: ",
                                      style: TextStyle(
                                          color: grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  TextSpan(
                                      text: user.userModel.cart[index].quantity
                                          .toString(),
                                      style: const TextStyle(
                                          color: primary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                ]),
                              ),
                              IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: red,
                                  ),
                                  onPressed: () async {
                                    app.changeLoading();
                                    bool value = await user.removeFromCart(
                                        cartItem: user.userModel.cart[index]);
                                    if (value) {
                                      user.reloadUserModel();
                                      const snackBar = SnackBar(
                                          content: Text("Removed from cart"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      app.changeLoading();
                                      return;
                                    } else {
                                      const snackBar = SnackBar(
                                          content:
                                              Text("Not removed from cart"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      app.changeLoading();
                                    }
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: "Total: ",
                      style: TextStyle(
                          color: grey,
                          fontSize: 22,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: "Ksh${user.userModel.totalCartPrice}",
                      style: const TextStyle(
                          color: Color(0xfff47a5a),
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xfff47a5a)),
                child: TextButton(
                    onPressed: () {
                      if (user.userModel.totalCartPrice == 0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                //this right here
                                child: SizedBox(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const <Widget>[
                                            Text(
                                              'Your cart is empty',
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              //this right here
                              child: SizedBox(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'You will be charged Ksh${user.userModel.totalCartPrice} upon delivery!',
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              var uuid = const Uuid();
                                              String id = uuid.v4();
                                              _orderServices.createOrder(
                                                  userId: user.user.uid,
                                                  id: id,
                                                  description:
                                                      "Some random description",
                                                  status: "complete",
                                                  totalPrice: user
                                                      .userModel.totalCartPrice,
                                                  cart: user.userModel.cart);
                                              for (CartItemModel cartItem
                                                  in user.userModel.cart) {
                                                bool value =
                                                    await user.removeFromCart(
                                                        cartItem: cartItem);
                                                if (value) {
                                                  user.reloadUserModel();
                                                } else {}
                                              }
                                              const snackBar = SnackBar(
                                                  content:
                                                      Text("Order created"));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Accept",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: green,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Reject",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: const Color(0xfff47a5a),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: const CustomText(
                      text: "Check out",
                      size: 20,
                      color: white,
                      weight: FontWeight.normal,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
