import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/cubit/state.dart';

import '../../../../../core/widgets/headers/header.dart';
import '../../home_page/widgets/category_container_shimmer.dart';
import '../cubit/search_category_cubit.dart';
import 'category_container_for_search_page.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<CategoriesCubit, CategoryState>(
            builder: (context, state) {
          if (state is LoadingCategories) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Center(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(6, (index) {
                  return const CategoryContainerShimmer();
                }),
              )),
            );
          }
          if (state is ErrorCategories) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (state is LoadedCategories) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state.selectedCategory != null) {
                controller.animateTo(
                  state.selectedCategory! * 70.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastEaseInToSlowEaseOut,
                );
              }
            });
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 116,
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: state.categories.length,
                            itemBuilder: (context, categoryIndex) {
                              final isSelected =
                                  categoryIndex == state.selectedCategory;

                              final category = state.categories[categoryIndex];
                              return CategoryContainer(
                                urlStringImage: category.banner,
                                title: category.title,
                                isSelected: isSelected,
                                onTap: () {
                                  if (!isSelected) {
                                    context
                                        .read<SearchCubit>()
                                        .selectCategory(category.guid);
                                  }
                                  if(isSelected) {
                                    context
                                        .read<SearchCubit>()
                                        .selectCategory('');
                                  }
                                  context
                                      .read<CategoriesCubit>()
                                      .selectCategory(categoryIndex);
                                },
                              );
                            },
                          ),
                        )
                      ]),
                ),

                if (state.selectedCategory != null)
                  Header(
                    title: state.categories[state.selectedCategory!].title,
                    size: 22,

                  ),
                if(state.selectedCategory == null)
                  const Header(title: "Часто ищут...",size: 22,)
              ],
            );
          }

          return const SizedBox();
        }),



      ],
    );
  }
}
