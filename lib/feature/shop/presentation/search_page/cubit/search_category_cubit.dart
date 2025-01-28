import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/cubit/state.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domain/usecases/get_categories_usecase.dart';
import '../../../domain/usecases/search_by_name_usecase.dart';
import '../../../services/app_location.dart';

class SearchCubit extends Cubit<SearchState> {
  final CategoriesCubit categoriesCubit;
  final SearchByNameUseCase searchByNameUseCase;
  Timer? _debounceTimer;
  String _selectedCategory = '';
  AppLocation appLocation = LocationService();

  SearchCubit(this.searchByNameUseCase, this.categoriesCubit)
      : super(SearchInitial());

  Future<void> search(String query) async {
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 600), () async {
      if (query.isNotEmpty) {
        categoriesCubit.disableSelectedCategory();
      }
      emit(SearchLoading());
      final userLocation = await appLocation.getCurrentLocation();
      final data = await searchByNameUseCase(
          SearchParams(query, _selectedCategory, userLocation));
      data.fold((failure) {
        emit(SearchError(failure.message));
      }, (searchResults) {
        emit(SearchLoaded(searchResults: searchResults));
      });
    });
  }

  void selectCategory(String categoryId) {
    _selectedCategory = categoryId;
    emit(SearchInitial());
    search('');
  }
}

class CategoriesCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  int? _previousCategory;

  CategoriesCubit({required this.getCategoriesUseCase})
      : super(InitialCategories());

  Future<void> fetchCategories() async {
    emit(LoadingCategories());

    try {
      final result = await getCategoriesUseCase.call(NoParams());
      result.fold((l) => emit(ErrorCategories(l.toString())),
          (categoriesList) => emit(LoadedCategories(categoriesList, null)));
    } catch (e) {
      emit(ErrorCategories(e.toString()));
    }
  }

  void disableSelectedCategory() {
    selectCategory(null);
  }

  void selectCategory(int? category) {
    if (state is LoadedCategories) {
      if (_previousCategory == category) {
        _previousCategory = null;
        emit(LoadedCategories(
          (state as LoadedCategories).categories,
          null,
        ));
        return;
      }
      final currentState = state as LoadedCategories;
      emit(LoadedCategories(
        currentState.categories,
        category,
      ));
      _previousCategory = category;
    }
  }
}
