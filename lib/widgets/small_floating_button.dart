import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final IconData icon;

  const SmallButton(this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(),
    );
  }
}
