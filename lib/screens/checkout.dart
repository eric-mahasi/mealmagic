import 'package:flutter/material.dart';
import 'package:mealmagic/models/cart_item.dart';
import 'package:mealmagic/providers/user.dart';
import 'package:mealmagic/services/order.dart';
import 'package:mealmagic/services/style.dart';
import 'package:mealmagic/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Checkout extends StatelessWidget {
  Checkout({Key? key}) : super(key: key);
  final _key = GlobalKey<ScaffoldState>();
  final OrderServices _orderServices = OrderServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: const Text(
          "Check out",
          style: TextStyle(
              color: Color(0xFF3a3737),
              fontWeight: FontWeight.w600,
              fontSize: 18),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(children: <Widget>[
        const Text("Select your payment method",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.bold)),
        const SizedBox(
          width: 10,
          height: 10,
        ),
        const PaymentMethodsWidget(),
        const Text("Enter an address you want the food delivered to",
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.bold)),
        Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    showCursor: true,
                    controller: _addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an delivery address';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.pin_drop,
                        color: Color(0xFF666666),
                        size: 12,
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle:
                          TextStyle(color: Color(0xFF666666), fontSize: 12),
                      hintText: "Delivery address",
                    ),
                  ),
                ]))
      ]),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 200,
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
                                    borderRadius: BorderRadius.circular(10.0)),
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
                      } else if (_formKey.currentState!.validate()) {
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
                                        Text(
                                          'You will be charged Ksh${user.userModel.totalCartPrice}. Order will be delivered to ${_addressController.text}',
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
                                                    totalPrice: user.userModel
                                                        .totalCartPrice,
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
                                                Navigator.pop(context);
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Dialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                        child: SizedBox(
                                                          height: 200,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: const <
                                                                      Widget>[
                                                                    Text(
                                                                      'Order placed successfully',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                                _addressController.text = "";
                                              },
                                              child: const Text(
                                                "Accept",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    const Color(0xfff47a5a),
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
                                                    color: Colors.black),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
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

enum PaymentMethod { cash, mpesa }

class PaymentMethodsWidget extends StatefulWidget {
  const PaymentMethodsWidget({Key? key}) : super(key: key);

  @override
  State<PaymentMethodsWidget> createState() => _PaymentMethodsWidgetState();
}

class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget> {
  PaymentMethod? _method = PaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Cash on delivery'),
          leading: Radio<PaymentMethod>(
            value: PaymentMethod.cash,
            groupValue: _method,
            onChanged: (PaymentMethod? value) {
              setState(() {
                _method = value;
              });
            },
            activeColor: const Color(0xfff47a5a),
          ),
          trailing: Image.asset(
            "assets/icons/ic_cash_on_delivery.png",
            width: 50,
            height: 50,
          ),
        ),
        ListTile(
          title: const Text('Mpesa'),
          leading: Radio<PaymentMethod>(
            value: PaymentMethod.mpesa,
            groupValue: _method,
            onChanged: (PaymentMethod? value) {
              setState(() {
                _method = value;
              });
            },
            activeColor: const Color(0xfff47a5a),
          ),
          trailing: Image.asset(
            "assets/icons/ic_mpesa.png",
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }
}
