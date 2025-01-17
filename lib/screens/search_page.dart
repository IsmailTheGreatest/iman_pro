import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/search_page/search_cubit.dart';
import 'package:iman_invest/widgets/list_of_store_item/list_of_store_item.dart';
import 'package:iman_invest/repositories/store_item_repository.dart';
import 'package:iman_invest/widgets/search_bars/search_bar_search_page.dart';
import '../models/store_item.dart';

import 'package:iman_invest/widgets/category_row/category_row_search_page.dart';

class SearchPage extends StatelessWidget {
  final String? category;

  const SearchPage({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: SearchView(category: category),
    );
  }
}

class SearchView extends StatelessWidget {
  final String? category;

  const SearchView({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final List<StoreItem> storeItems = StoreRepository().storeItems;
    final TextEditingController controller = TextEditingController();
    final FocusNode focusNode = FocusNode();

    //if category is passed, set the text of the search bar
    if (category != null) {
      controller.text = category!;
    }
    //for requesting focus for search bar, after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarInSearchPage(
                  controller: controller, focusNode: focusNode),
              //if category is not passed, show the category row
              if (category == null) const CategoryRow(),
              //list of store items
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: storeItems.length,
                itemBuilder: (context, index) {
                  final item = storeItems[index];
                  return ListOfStoreItem(icon: item.icon, title: item.title);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
