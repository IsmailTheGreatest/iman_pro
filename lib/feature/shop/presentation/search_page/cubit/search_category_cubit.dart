import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/core/usecase/usecase.dart';
import 'package:iman_invest/feature/shop/domain/usecases/search_by_name_usecase.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/cubit/categories_cubit.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/cubit/state.dart';
import 'package:iman_invest/feature/shop/services/app_location.dart';

/// SearchCubit class
class SearchCubit extends Cubit<SearchState> {
  /// SearchCubit constructor
  SearchCubit(this.searchByNameUseCase, this.categoriesCubit)
      : super(SearchInitial());

  ///
  final CategoriesCubit categoriesCubit;

  ///
  final SearchByNameUseCase searchByNameUseCase;
  Timer? _debounceTimer;
  String _selectedCategory = '';

  ///
  final AppLocation appLocation = LocationService();

  /// search method
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
        SearchParams(query, _selectedCategory, userLocation),
      );
      data.fold((failure) {
        emit(SearchError(failure.message));
      }, (searchResults) {
        emit(SearchLoaded(searchResults: searchResults));
      });
    });
  }

  /// selectCategory method
  void selectCategory(String categoryId) {
    _selectedCategory = categoryId;
    emit(SearchInitial());
    search('');
  }
}
