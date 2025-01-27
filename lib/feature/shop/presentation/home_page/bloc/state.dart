
import 'package:equatable/equatable.dart';
import 'package:iman_invest/feature/shop/data/models/category.dart';

class AddBannerState extends Equatable {
  const AddBannerState();

  @override
  List<Object?> get props => [];
}
class Initial extends AddBannerState {}
class LoadingAd extends AddBannerState {}
class LoadedAd extends AddBannerState {
  final List<String> bannerImagesList;

  const LoadedAd(this.bannerImagesList);

  @override
  List<Object?> get props => [bannerImagesList];
}
class Error extends AddBannerState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}
class LoadingCategories extends CategoriesState {}
class InitialCategories extends CategoriesState {}
class ErrorCategories extends CategoriesState {
  final String message;

  const ErrorCategories(this.message);

  @override
  List<Object?> get props => [message];
}
class LoadedCategories extends CategoriesState {
  final List<Category> categoriesList;

  const LoadedCategories(this.categoriesList);

  @override
  List<Object?> get props => [categoriesList];
}