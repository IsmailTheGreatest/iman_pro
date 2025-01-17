import 'package:flutter/material.dart';

import 'package:iman_invest/widgets/category_containers/category_container_for_main_page.dart';
import 'package:iman_invest/repositories/categories_repository.dart';
import 'package:iman_invest/models/category.dart';


class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = CategoriesRepository().categories;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(categories.length, (index) {
              final category = categories[index];
              return CategoryContainer(
                urlStringImage: category.urlStringImage,
                title: category.title,
              );
            }),
          ),
        ),

      ],
    );
  }
}
