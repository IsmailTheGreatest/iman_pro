import 'package:iman_invest/helper_functions/navigate_without_transition.dart';
import 'package:flutter/material.dart';
import 'package:iman_invest/screens/search_page.dart';
class SearchBarMainPage extends StatelessWidget {
  const SearchBarMainPage({
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
            navigateWithoutTransition(context, const SearchPage());
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