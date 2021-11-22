import 'package:flutter/material.dart';
import 'package:mealmagic/models/restaurant.dart';
import 'package:mealmagic/services/style.dart';
import 'package:mealmagic/widgets/small_floating_button.dart';
import 'package:transparent_image/transparent_image.dart';

import 'loading.dart';

class RestaurantWidget extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantWidget({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:2, left:2, right: 2, bottom: 4),
      child: Stack(
        children: <Widget>[
          _backgroundImage(restaurant.image),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SmallButton(Icons.favorite),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.star,
                            color: Color(0xfff47a5a),
                            size: 20,
                          ),
                        ),
                        Text(restaurant.rating.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.05),
                          Colors.black.withOpacity(0.025),
                        ],
                      )),
                ),
              )),
          Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                      child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "${restaurant.name} \n",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const TextSpan(
                          text: "Average meal price: ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                      TextSpan(
                          text: "Ksh${restaurant.avgPrice} \n",
                          style: const TextStyle(fontSize: 16)),
                    ], style: const TextStyle(color: white)),
                  ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _backgroundImage(String image){
    if (image.isEmpty) {
      return Container(
          height: 210,
          decoration: BoxDecoration(
            color: grey.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Image.asset(
              "images/table.png",
              width: 120,
            ),
          ));
    }else{
      return Padding(
        padding: const EdgeInsets.all(0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(height: 120, child: Loading()),
                )),
                Center(
                  child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: restaurant.image),
                )
              ],
            )),
      );
    }
  }
}
