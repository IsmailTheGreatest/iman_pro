import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'feature/shop/presentation/home_page/home_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
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
