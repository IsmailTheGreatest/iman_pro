import 'package:flutter/material.dart';

import 'package:iman_invest/core/utils/navigate_without_transition.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/search_page.dart';
///
class SearchBarHomePage extends StatelessWidget {

  ///
  const SearchBarHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xffF4F4F5),
          borderRadius: BorderRadius.circular(18),
        ),
        child: TextField(
          readOnly: true,
          enabled: true,
          onTap: () {
            navigateWithoutTransition(context, const  SearchPage());
          },
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xff818188),
            ),
            enabled: false,
            hintText: 'Поиск по магазинам',
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff818188),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
