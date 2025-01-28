import 'package:equatable/equatable.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';

import '../../../data/models/category.dart';



abstract class SearchState extends Equatable{


  @override
  List<Object?> get props => [];}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
  @override
  List<Object?> get props => [message];
}
class SearchLoaded extends SearchState {

  final List<Merchant> searchResults;
  SearchLoaded( {required this.searchResults});
  @override
  List<Object?> get props => [searchResults];
}
abstract class CategoryState extends Equatable{
  @override
  List<Object?> get props => [];
}
class InitialCategories extends CategoryState {}
class LoadingCategories extends CategoryState {}
class LoadedCategories extends CategoryState {
  final List<Category> categories;
  final int? selectedCategory;
  LoadedCategories(this.categories, this.selectedCategory);
  @override
  List<Object?> get props => [categories];
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadedCategories &&
        other.categories == categories &&
        other.selectedCategory == selectedCategory;
  }

  @override
  int get hashCode => categories.hashCode ^ selectedCategory.hashCode;
}
class ErrorCategories extends CategoryState {
  final String message;
  ErrorCategories(this.message);
  @override
  List<Object?> get props => [message];
}
