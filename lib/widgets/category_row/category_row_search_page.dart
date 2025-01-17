import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/bloc/search_page/search_cubit.dart';
import 'package:iman_invest/widgets/category_containers/category_container_for_search_page.dart';
import 'package:iman_invest/repositories/categories_repository.dart';
import 'package:iman_invest/models/category.dart';
import 'package:iman_invest/widgets/headers/header.dart';
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
                isSelected: context.watch<SearchCubit>().state.selectedCategoryIndex == index,
                onTap: () {
                  context.read<SearchCubit>().updateCategory(index, category.title);
                },
              );
            }),
          ),
        ),
        if (context.watch<SearchCubit>().state.selectedCategoryIndex == null)
          const Header(
            title: "Часто ищут",
            size: 22,
          ),
        if (context.watch<SearchCubit>().state.selectedCategory != null)
          Header(
            title: context.watch<SearchCubit>().state.selectedCategory!,
            size: 22,
          ),
      ],
    );
  }
}