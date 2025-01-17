import 'package:flutter/material.dart';
class Header extends StatelessWidget {
  final String title;
  final double? size;
  const Header({
    super.key, required this.title, this.size
  });


  @override
  Widget build(BuildContext context) {
    double fontSize= 26;
    if(size != null){
      fontSize= size!;
    }
    return   Padding(
      padding:  const EdgeInsets.all(20.0),
      child:  Text(title, style:  TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),),
    );
  }
}