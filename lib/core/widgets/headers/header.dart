import 'package:flutter/material.dart';

///
class Header extends StatelessWidget {
  ///
  const Header({required this.title, super.key, this.size});

  ///
  final String title;

  ///
  final double? size;

  @override
  Widget build(BuildContext context) {
    double? fontSize = 26;
    if (size != null) {
      fontSize = size;
    }
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        title,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
    );
  }
}
