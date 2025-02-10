import 'package:flutter/material.dart';
import 'package:iman_invest/core/utils/navigate_without_transition.dart';
import 'package:iman_invest/feature/shop/data/models/category.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/search_page.dart';

///
class CategoryContainer extends StatelessWidget {
  ///
  const CategoryContainer({
    required this.category,
    required this.index,
    super.key,
  });

  ///
  final Category category;

  ///
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          navigateWithoutTransition(
            context,
            SearchPage(
              category: category,
              index: index,
            ),
          );
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xfff4f4f5),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Visibility(
                    visible: category.banner.isNotEmpty,
                    child: Image.network(
                      category.banner,
                      colorBlendMode: BlendMode.dstATop,
                      opacity: const AlwaysStoppedAnimation(1),
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Visibility(
                    visible: category.banner.isEmpty,
                    child: const Icon(
                      Icons.store,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: SizedBox(
                width: 80,
                child: Text(
                  category.title,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff040415),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
