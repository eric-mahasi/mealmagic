import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const RESTAURANT_ID = "restaurantId";
  static const RESTAURANT = "restaurant";
  static const RATES = "rates";
  static const USER_LIKES = "userLikes";
  static const FEATURED = "featured";

  late String _id;
  late String _name;
  late String _restaurantId;
  late String _restaurant;
  late String _image;
  late double _rating;
  late int _price;
  late int _rates;
  late bool _featured;

  String get id => _id;

  String get name => _name;

  String get restaurant => _restaurant;

  String get restaurantId => _restaurantId;

  String get image => _image;

  double get rating => _rating;

  int get price => _price;

  int get rates => _rates;

  bool get featured => _featured;

  // public variable
  bool liked = false;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot[ID];
    _image = snapshot[IMAGE];
    _restaurant = snapshot[RESTAURANT];
    _restaurantId = snapshot[RESTAURANT_ID].toString();
    _price = snapshot[PRICE].floor();
    _rating = snapshot[RATING];
    _rates = snapshot[RATES];
    _name = snapshot[NAME];
    _featured = snapshot[FEATURED];
  }
}
