import 'package:flutter/material.dart';
import 'package:iman_invest/feature/shop/data/models/category.dart';
import '../../../../../core/utils/navigate_without_transition.dart';
import '../../search_page/search_page.dart';

class CategoryContainer extends StatelessWidget {
  final Category category;
  final int index;

  const CategoryContainer(
      {super.key, required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          navigateWithoutTransition(
              context,
              SearchPage(
                category: category,
                index: index,
              ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      )),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: SizedBox(
                  width: 80,
                  child: Text(
                    category.title,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff040415)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
