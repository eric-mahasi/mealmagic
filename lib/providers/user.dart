import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mealmagic/models/order.dart';
import 'package:mealmagic/services/order.dart';
import 'package:mealmagic/services/user.dart';
import 'package:mealmagic/models/cart_item.dart';
import 'package:mealmagic/models/products.dart';
import 'package:mealmagic/models/user.dart';
import 'package:uuid/uuid.dart';


enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier{
  FirebaseAuth _auth;
  late User _user;
  Status _status = Status.Uninitialized;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServicse = UserServices();
  OrderServices _orderServices = OrderServices();
  late UserModel _userModel;

//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;

  // public variables
  List<OrderModel> orders = [];

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();


  UserProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }


  Future<bool> signUp()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((result){
        _firestore.collection('users').doc(result.user!.uid).set({
          'first name':first_name.text,
          'last name':last_name.text,
          'email':email.text,
          'uid':result.user!.uid,
          "likedFood": [],
          "likedRestaurants": []
        });
      });
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut()async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController(){
    first_name.text = "";
    last_name.text = "";
    password.text = "";
    email.text = "";
  }

  Future<void> reloadUserModel()async{
    _userModel = await _userServicse.getUserById(user.uid);
    notifyListeners();
  }


  Future<void> _onStateChanged(User? firebaseUser) async{
    if(firebaseUser == null){
      _status = Status.Unauthenticated;
    }else{
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServicse.getUserById(user.uid);
    }
    notifyListeners();
  }

  Future<bool> addToCard({required ProductModel product, required int quantity})async{
    print("THE PRODUC IS: ${product.toString()}");
    print("THE qty IS: ${quantity.toString()}");

    try{
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List cart = _userModel.cart;
//      bool itemExists = false;
      Map cartItem ={
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "restaurantId": product.restaurantId,
        "totalRestaurantSale": product.price * quantity,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
//      if(!itemExists){
      print("CART ITEMS ARE: ${cart.toString()}");
      _userServicse.addToCart(userId: _user.uid, cartItem: item);
//      }



      return true;
    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }

  }

  getOrders()async{
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({required CartItemModel cartItem})async{
    print("THE PRODUC IS: ${cartItem.toString()}");

    try{
      _userServicse.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }

  }
}