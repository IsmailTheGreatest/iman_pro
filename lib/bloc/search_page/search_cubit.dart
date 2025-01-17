
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/bloc/search_page/state/state.dart';


class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());

  void updateCategory(int index, String category) {
    emit(SearchState(selectedCategoryIndex: index, selectedCategory: category));
  }
}