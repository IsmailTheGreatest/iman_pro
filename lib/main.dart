import 'package:flutter/material.dart';

import 'feature/shop/presentation/home_page/home_page.dart';


void main() {
  runApp(const MainPage());
}


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Gilroy',
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}