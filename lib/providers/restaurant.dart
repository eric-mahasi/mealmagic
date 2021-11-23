import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../services/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  final RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchedRestaurants = [];

  late RestaurantModel restaurant;

  RestaurantProvider.initialize() {
    loadRestaurants();
  }

  loadRestaurants() async {
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({required String restaurantId}) async {
    restaurant = await _restaurantServices.getRestaurantById(id: restaurantId);
    notifyListeners();
  }

  Future search({required String name}) async {
    searchedRestaurants =
        await _restaurantServices.searchRestaurant(restaurantName: name);
    notifyListeners();
  }
}
