import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iman_invest/widgets/headers/header.dart';
import 'package:iman_invest/widgets/category_row/category_row_main_page.dart';
import '../widgets/banner_row/add_banner_row.dart';
import '../widgets/banner_row/partners_row.dart';
import '../widgets/banner_row/small_partners_row.dart';
import '../widgets/search_bars/search_bar_main_page.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //magazini and location icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Магазины",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SvgPicture.asset(
                    'assets/icons.svg',
                    height: 26,
                    width: 26,
                  ),
                ],
              ),
            ),
            const SearchBarMainPage(),
            const SizedBox(
              height: 10,
            ),
            const AdBannerRow(),
            const SizedBox(
              height: 10,
            ),
            const CategoryRow(),
            const Header(
              title: "Поблизости",
              size: 24,
            ),
            const PartnersRow(),
            const Header(
              title: "Вам может понравится",
              size: 24,
            ),
            const SmallPartnersRow(),
          ],
        )),
      ),
    );
  }
}


