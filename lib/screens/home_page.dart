import 'package:flutter/material.dart';
import 'package:mealmagic/animation/scale_route.dart';
import 'package:mealmagic/core/sign_in/sign_in.dart';
import 'package:mealmagic/providers/app.dart';
import 'package:mealmagic/providers/product.dart';
import 'package:mealmagic/providers/restaurant.dart';
import 'package:mealmagic/screens/restaurant.dart';
import 'package:mealmagic/services/screen_navigation.dart';
import 'package:mealmagic/widgets/bottom_nav_bar.dart';
import 'package:mealmagic/widgets/popular_foods.dart';
import 'package:mealmagic/widgets/restaurant.dart';
import 'package:mealmagic/widgets/search.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final app = Provider.of<AppProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF3a3737),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "What would you like to eat?",
          style: TextStyle(
              color: Color(0xFF3a3737),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Color(0xFF3a3737),
              ),
              onPressed: () {
                Navigator.push(context, ScaleRoute(page: const SignInPage()));
              })
        ],
      ),
      body: ListView(
        children: <Widget>[

            const SearchWidget(),
            const PopularFoodsWidget(),
          Column(children: restaurantProvider.restaurants
              .map((item) => GestureDetector(
            onTap: () async {
              app.changeLoading();

              await productProvider.loadProductsByRestaurant(
                  restaurantId: item.id.toString()
              );
              app.changeLoading();

              changeScreen(
                  context,
                  RestaurantScreen(
                    restaurantModel: item,
                  ));
            },
            child: RestaurantWidget(
              restaurant: item,
            ),
          ))
              .toList()),

        ],
      ),
      bottomNavigationBar: const BottomNavBarWidget(),
    );
  }
}
