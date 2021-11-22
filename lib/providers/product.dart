import 'package:flutter/material.dart';

import '../models/products.dart';
import '../services/product.dart';

class ProductProvider with ChangeNotifier{
  final ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsByRestaurant = [];
  List<ProductModel> productsSearched = [];

  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({required String categoryName})async{
    productsByCategory = await _productServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }

  Future loadProductsByRestaurant({required String restaurantId})async{
    productsByRestaurant = await _productServices.getProductsByRestaurant(id: restaurantId);
    notifyListeners();
  }

//  likeDislikeProduct({String userId, ProductModel product, bool liked})async{
//    if(liked){
//      if(product.userLikes.remove(userId)){
//        _productServices.likeOrDislikeProduct(id: product.id, userLikes: product.userLikes);
//      }else{
//        print("THE USER WA NOT REMOVED");
//      }
//    }else{
//
//      product.userLikes.add(userId);
//        _productServices.likeOrDislikeProduct(id: product.id, userLikes: product.userLikes);
//
//
//      }
//  }

  Future search({required String productName})async{
    productsSearched = await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }
}