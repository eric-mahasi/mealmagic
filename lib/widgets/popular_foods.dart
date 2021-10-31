import 'package:flutter/material.dart';
import 'package:mealmagic/animation/rotation_route.dart';
import 'package:mealmagic/animation/scale_route.dart';
import 'package:mealmagic/screens/food_details.dart';

class PopularFoodsWidget extends StatefulWidget {
  @override
  _PopularFoodsWidgetState createState() => _PopularFoodsWidgetState();
}

class _PopularFoodsWidgetState extends State<PopularFoodsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 265,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          PopularFoodTitle(),
          Expanded(
            child: PopularFoodItems(),
          )
        ],
      ),
    );
  }
}

class PopularFoodTiles extends StatelessWidget {
  String name;
  String imageUrl;
  String price;
  String slug;

  PopularFoodTiles(
      {Key? key,
        required this.name,
        required this.imageUrl,
        required this.price,
        required this.slug})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, ScaleRoute(page: FoodDetailsPage()));
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(boxShadow: [
              /* BoxShadow(
                color: Color(0xFFfae3e2),
                blurRadius: 15.0,
                offset: Offset(0, 0.75),
              ),*/
            ]),
            child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Container(
                  width: 170,
                  height: 210,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Center(
                                child: Image.asset(
                                  '/images/popular_foods/' +
                                      imageUrl +
                                      ".png",
                                  width: 130,
                                  height: 140,
                                )),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, top: 5),
                            child: Text(name,
                                style: TextStyle(
                                    color: Color(0xFF6e6e71),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 3, left: 5),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                            child: Text('Ksh ' + price,
                                style: TextStyle(
                                    color: Color(0xFF6e6e71),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class PopularFoodTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Popular Foods",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.bold),
          ),
          Text(
            "See all",
            style: TextStyle(
                fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
  }
}

class PopularFoodItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        PopularFoodTiles(
            name: "Fried Egg",
            imageUrl: "ic_popular_food_1",
            price: '15.06',
            slug: "fried_egg"),
        PopularFoodTiles(
            name: "Mixed Vegetable",
            imageUrl: "ic_popular_food_3",
            price: "17.03",
            slug: ""),
        PopularFoodTiles(
            name: "Salad With Chicken",
            imageUrl: "ic_popular_food_4",
            price: "11.00",
            slug: ""),
        PopularFoodTiles(
            name: "Mixed Salad",
            imageUrl: "ic_popular_food_5",
            price: "11.10",
            slug: ""),
        PopularFoodTiles(
            name: "Red meat,Salad",
            imageUrl: "ic_popular_food_2",
            price: "12.00",
            slug: ""),
        PopularFoodTiles(
            name: "Mixed Salad",
            imageUrl: "ic_popular_food_5",
            price: "11.10",
            slug: ""),
        PopularFoodTiles(
            name: "Potato,Meat fry",
            imageUrl: "ic_popular_food_6",
            price: "23.0",
            slug: ""),
        PopularFoodTiles(
            name: "Fried Egg",
            imageUrl: "ic_popular_food_1",
            price: '15.06',
            slug: "fried_egg"),
        PopularFoodTiles(
            name: "Red meat,Salad",
            imageUrl: "ic_popular_food_2",
            price: "12.00",
            slug: ""),
      ],
    );
  }
}


