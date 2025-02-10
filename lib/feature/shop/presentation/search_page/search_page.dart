import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/feature/shop/data/models/category.dart';
import 'package:iman_invest/feature/shop/domain/usecases/get_categories_usecase.dart';
import 'package:iman_invest/feature/shop/domain/usecases/search_by_name_usecase.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/cubit/categories_cubit.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/cubit/search_category_cubit.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/cubit/state.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/widgets/category_row_search_page.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/widgets/list_of_store_item.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/widgets/list_of_store_item_shimmer.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/widgets/search_bar_search_page.dart';

/// SearchPage class
class SearchPage extends StatelessWidget {
  /// SearchPage constructor
  const SearchPage({super.key, this.category, this.index});

  /// SearchPage constructor
  final Category? category;

  /// SearchPage constructor
  final int? index;

  @override
  Widget build(BuildContext context) {
    /// CategoriesCubit instance
    final categoriesCubit =
        CategoriesCubit(getCategoriesUseCase: GetCategoriesUseCase());
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
          create: (context) =>
              SearchCubit(SearchByNameUseCase(), categoriesCubit),
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) => categoriesCubit,
        ),
      ],
      child: SearchView(category: category, index: index),
    );
  }
}

/// SearchView class
class SearchView extends StatelessWidget {
  /// SearchView constructor
  const SearchView({super.key, this.category, this.index});

  /// SearchView constructor
  final Category? category;

  /// SearchView constructor
  final int? index;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final focusNode = FocusNode();

    //for requesting focus for search bar, after the widget is built
    if (category == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusNode.requestFocus();
      });
    }

    return FutureBuilder(
      future: context.read<CategoriesCubit>().fetchCategories(),
      builder: (context, snapshot) {
        if (category != null) {
          context.read<SearchCubit>().selectCategory(category!.guid);
          context.read<CategoriesCubit>().selectCategory(index);
        } else {
          context.read<SearchCubit>().search('');
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBarInSearchPage(
                    controller: controller,
                    focusNode: focusNode,
                  ),
                  //if category is not passed, show the category row
                  const CategoryRow(),
                  //list of store items
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchInitial || state is SearchLoading) {
                        return ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              const ListOfStoreItemShimmer(),
                        );
                      }
                      if (state is SearchLoaded) {
                        if (state.searchResults.isEmpty) {
                          return const Center(
                            child: Text('No results found'),
                          );
                        }
                        return Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.searchResults.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListOfStoreItem(
                                  merchant: state.searchResults[index],
                                );
                              },
                            ),
                          ],
                        );
                      } else if (state is SearchError) {

                        return Center(
                          child: Text( state.message),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
