
import 'package:equatable/equatable.dart';
import 'package:iman_invest/feature/shop/data/models/category.dart';
///
class AddBannerState extends Equatable {
  ///
  const AddBannerState();

  @override
  List<Object?> get props => [];
}
///
class Initial extends AddBannerState {}
///
class LoadingAd extends AddBannerState {}
///
class LoadedAd extends AddBannerState {
///
  const LoadedAd(this.bannerImagesList);
  ///
  final List<String> bannerImagesList;

  @override
  List<Object?> get props => [bannerImagesList];
}
///
class Error extends AddBannerState {
///
  const Error(this.message);
  ///
  final String message;

  @override
  List<Object?> get props => [message];
}
///
class CategoriesState extends Equatable {
  ///
  const CategoriesState();

  @override
  List<Object?> get props => [];
}
///
class LoadingCategories extends CategoriesState {}
///
class InitialCategories extends CategoriesState {}
///
class ErrorCategories extends CategoriesState {
///
  const ErrorCategories(this.message);
  ///
  final String message;

  @override
  List<Object?> get props => [message];
}
///
class LoadedCategories extends CategoriesState {
///
  const LoadedCategories(this.categoriesList);
  ///
  final List<Category> categoriesList;

  @override
  List<Object?> get props => [categoriesList];
}
