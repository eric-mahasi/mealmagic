import 'package:flutter/material.dart';
import 'package:mealmagic/animation/scale_route.dart';
import 'package:mealmagic/screens/food_order.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        switch(index) {
          case 2:
            Navigator.push(context, ScaleRoute(page: FoodOrderPage()));
            break;
        }
      });
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            'Home',
            style: TextStyle(color: Color(0xFF2c2b2b)),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          title: Text(
            'Orders',
            style: TextStyle(color: Color(0xff2c2b2b)),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text(
            'Cart',
            style: TextStyle(color: Color(0xFF2c2b2b)),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user),
          title: Text(
            'Account',
            style: TextStyle(color: Color(0xFF2c2b2b)),
          ),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xfff47a5a),
      onTap: _onItemTapped,
    );
  }
}
