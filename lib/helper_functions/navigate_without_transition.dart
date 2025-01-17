import 'package:flutter/material.dart';

void navigateWithoutTransition(BuildContext context, Widget page) {
  Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child; // No transition; widget simply appears
    },
  ));
}
