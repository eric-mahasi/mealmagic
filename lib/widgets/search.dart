import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(
              width: 0,
              color: Color(0xfff47a5a),
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xfff47a5a),
          ),
          fillColor: Color(0xFFFAFAFA),
          suffixIcon: Icon(
            Icons.sort,
            color: Color(0xfff47a5a),
          ),
          hintStyle: TextStyle(color: Color(0xFFd0cece), fontSize: 18),
          hintText: "Search",
        ),
      ),
    );
  }
}
