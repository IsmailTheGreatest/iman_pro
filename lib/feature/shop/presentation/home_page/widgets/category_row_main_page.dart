import 'package:flutter/material.dart';


import '../../../domain/entities/category.dart';
import '../../../hardcoded_resources/categories_repository.dart';
import 'category_container_for_main_page.dart';



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
