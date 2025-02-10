import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/core/usecase/usecase.dart';
import 'package:iman_invest/feature/shop/domain/usecases/get_categories_usecase.dart';
import 'package:iman_invest/feature/shop/presentation/search_page/cubit/state.dart';

/// CategoriesCubit class
class CategoriesCubit extends Cubit<CategoryState> {
  /// CategoriesCubit constructor
  CategoriesCubit({required this.getCategoriesUseCase})
      : super(InitialCategories());

  /// CategoriesCubit constructor
  final GetCategoriesUseCase getCategoriesUseCase;
  int? _previousCategory;

  /// fetchCategories method
  Future<void> fetchCategories() async {
    emit(LoadingCategories());

    try {
      final result = await getCategoriesUseCase.call(NoParams());
      result.fold(
        (l) => emit(ErrorCategories(l.toString())),
        (categoriesList) => emit(LoadedCategories(categoriesList, null)),
      );
    } on Exception catch (e) {
      emit(ErrorCategories(e.toString()));
    }
  }

  /// disableSelectedCategory method
  void disableSelectedCategory() {
    selectCategory(null);
  }

  /// selectCategory method
  void selectCategory(int? category) {
    if (state is LoadedCategories) {
      if (_previousCategory == category) {
        _previousCategory = null;
        emit(
          LoadedCategories(
            (state as LoadedCategories).categories,
            null,
          ),
        );
        return;
      }
      final currentState = state as LoadedCategories;
      emit(
        LoadedCategories(
          currentState.categories,
          category,
        ),
      );
      _previousCategory = category;
    }
  }
}
