import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iman_invest/core/usecase/usecase.dart';
import 'package:iman_invest/feature/shop/domain/usecases/get_banner_images_usecase.dart';
import 'package:iman_invest/feature/shop/presentation/home_page/bloc/state.dart';
import '../../../domain/usecases/get_categories_usecase.dart';
import 'event.dart';


class HomePageBloc extends Bloc<BannerEvent, AddBannerState> {
  final GetBannerImages getBannerImages;
  final GetCategoriesUseCase getCategoriesUseCase;
  HomePageBloc( {required this.getBannerImages, required this.getCategoriesUseCase}) : super(Initial()){

    on<FetchBannerImages>((event, emit) async {

      emit(LoadingAd());
      try {
        final bannerImagesList = await getBannerImages.call(NoParams());
        emit(LoadedAd(bannerImagesList));
      } catch (e) {
        emit(Error(e.toString()));
      }
    });
  }

}
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {

  final GetCategoriesUseCase getCategoriesUseCase;
  CategoriesBloc({required this.getCategoriesUseCase}) : super(InitialCategories()){

    on<FetchCategories>((event, emit) async {
      emit(LoadingCategories());

      try {
        final categoriesList = await getCategoriesUseCase.call(NoParams());
        emit(LoadedCategories(categoriesList));

      } catch (e) {

        emit(ErrorCategories(e.toString()));
      }
    });
  }
}
