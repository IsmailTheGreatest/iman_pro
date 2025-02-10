import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/core/usecase/usecase.dart';
import 'package:iman_invest/feature/shop/domain/usecases/get_banner_images_usecase.dart';
import 'package:iman_invest/feature/shop/domain/usecases/get_categories_usecase.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/event.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/state.dart';

/// HomePageBloc class
class HomePageBloc extends Bloc<BannerEvent, AddBannerState> {
  /// HomePageBloc constructor
  HomePageBloc({
    required this.getBannerImages,
    required this.getCategoriesUseCase,
  }) : super(Initial()) {
    on<FetchBannerImages>((event, emit) async {
      emit(LoadingAd());
      try {
        final result = await getBannerImages.call(NoParams());
        result.fold((l) => emit(Error(l.message)), (r) => emit(LoadedAd(r)));
      } on Exception catch (e) {
        emit(Error(e.toString()));
      }
    });
  }

  ///
  final GetBannerImages getBannerImages;

  ///
  final GetCategoriesUseCase getCategoriesUseCase;
}

/// CategoriesBloc class
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  /// CategoriesBloc constructor
  CategoriesBloc({required this.getCategoriesUseCase})
      : super(InitialCategories()) {
    on<FetchCategories>((event, emit) async {
      emit(LoadingCategories());

      try {
        final result = await getCategoriesUseCase.call(NoParams());
        result.fold(
          (l) => emit(ErrorCategories(l.message)),
          (categoriesList) => emit(LoadedCategories([...categoriesList])),
        );
      } on Exception catch (e) {
        emit(ErrorCategories(e.toString()));
      }
    });
  }

  ///
  final GetCategoriesUseCase getCategoriesUseCase;
}
