import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/home_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  await dotenv.load();
  runApp(const MainPage());
}
/// MainPage class
class MainPage extends StatelessWidget {
  /// MainPage constructor
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
