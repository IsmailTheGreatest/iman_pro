import 'package:bloc/bloc.dart';

class SearchState {
  final int? selectedCategoryIndex;
  final String? selectedCategory;

  SearchState({this.selectedCategoryIndex, this.selectedCategory});
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());

  void updateCategory(int index, String category) {
    emit(SearchState(selectedCategoryIndex: index, selectedCategory: category));
  }
}