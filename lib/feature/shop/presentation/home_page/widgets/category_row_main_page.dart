import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/event.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/homepage_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/state.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/widgets/category_container_for_main_page.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/widgets/category_container_shimmer.dart';

///
class CategoryRow extends StatelessWidget {
  ///
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoriesBloc>().add(FetchCategories());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
            if (state is LoadingCategories) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(5, (index) {
                  return const CategoryContainerShimmer();
                }),
              );
            }
            if (state is ErrorCategories) {
              return const SizedBox();
            }
            if (state is LoadedCategories) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 116,
                    ),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.categoriesList.length,
                        itemBuilder: (context, index) {
                          final category = state.categoriesList[index];
                          return CategoryContainer(
                            category: category,
                            index: index,
                          );
                        },),
                  ),
                ],
              );
            }
            return const SizedBox();
          },),
        ),
      ],
    );
  }
}
