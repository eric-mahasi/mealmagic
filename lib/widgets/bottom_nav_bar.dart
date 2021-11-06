import 'package:flutter/material.dart';
import 'package:mealmagic/animation/scale_route.dart';
import 'package:mealmagic/screens/food_order.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({Key? key}) : super(key: key);

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
            Navigator.push(context, ScaleRoute(page: const FoodOrderPage()));
            break;
        }
      });
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label:
            'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label:
            'Orders'
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label:
            'Cart',

        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user),
          label:
            'Account',

        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xfff47a5a),
      onTap: _onItemTapped,
    );
  }
}
