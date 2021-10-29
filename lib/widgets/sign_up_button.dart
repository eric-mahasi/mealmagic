import 'package:flutter/material.dart';
import 'package:mealmagic/animation/scale_route.dart';
import 'package:mealmagic/screens/home_page.dart';

class SignUpButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: MaterialButton(
          color: Color(0xfff47a5a),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
            child: Text(
              "SIGN UP",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontFamily: "WorkSansBold"),
            ),
          ),
          onPressed: () => {
            Navigator.push(context, ScaleRoute(page: HomePage()))
          }),
    );
  }
}