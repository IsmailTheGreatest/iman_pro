import 'package:equatable/equatable.dart';
///
class BannerEvent extends Equatable {
  ///
  const BannerEvent();

  @override
  List<Object?> get props => [];
}
///
class FetchBannerImages extends BannerEvent {}
///
class CategoriesEvent extends Equatable {
  ///
  const CategoriesEvent();
  @override
  List<Object?> get props => [];}
///
class FetchCategories extends CategoriesEvent {}
