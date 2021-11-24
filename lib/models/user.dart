import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealmagic/models/cart_item.dart';

class UserModel {
  static const ID = "uid";
  static const FIRST_NAME = "first name";
  static const LAST_NAME = "last name";
  static const EMAIL = "email";
  static const CART = "cart";

  late String _firstName;
  late String _lastName;
  late String _email;
  late String _id;
  late int _priceSum = 0;

  //  getters
  String get first_name => _firstName;

  String get last_name => _lastName;

  String get email => _email;

  String get id => _id;

  //  public variable
  late List<CartItemModel> cart;
  late int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _firstName = snapshot[FIRST_NAME];
    _lastName = snapshot[LAST_NAME];
    _email = snapshot[EMAIL];
    _id = snapshot[ID];
    cart = _convertCartItems(snapshot[CART]);
    totalCartPrice =
        snapshot[CART] == null ? 0 : getTotalPrice(cart: snapshot[CART]);
  }

  int getTotalPrice({required List cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      num _priceSumNum;
      _priceSumNum = _priceSum + cartItem["price"] * cartItem["quantity"];
      _priceSum = _priceSumNum.toInt();
    }
    int total = _priceSum;
    return total;
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}
