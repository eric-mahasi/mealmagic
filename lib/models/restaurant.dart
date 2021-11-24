import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  static const ID = "id";
  static const NAME = "name";
  static const AVG_PRICE = "avgPrice";
  static const RATING = "rating";
  static const RATES = "rates";
  static const IMAGE = "image";
  static const POPULAR = "popular";
  static const USER_LIKES = "userLikes";

  late int _id;
  late String _name;
  late String _image;
  late List<String> _userLikes;
  late double _rating;
  late double _avgPrice;
  late bool _popular;
  late int _rates;

//  getters
  int get id => _id;

  String get name => _name;

  String get image => _image;

  List<String> get userLikes => _userLikes;

  double get avgPrice => _avgPrice;

  double get rating => _rating;

  bool get popular => _popular;

  int get rates => _rates;

  // public variable
  bool liked = false;

  RestaurantModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot[ID];
    _name = snapshot[NAME];
    _image = snapshot[IMAGE];
    _avgPrice = snapshot[AVG_PRICE];
    _rating = snapshot[RATING];
    _popular = snapshot[POPULAR];
    _rates = snapshot[RATES];
  }
}
