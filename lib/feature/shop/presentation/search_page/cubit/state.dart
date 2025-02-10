import 'package:equatable/equatable.dart';
import 'package:iman_invest/feature/shop/data/models/category.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';


/// SearchState class
abstract class SearchState extends Equatable{


  @override
  List<Object?> get props => [];}
/// SearchInitial class
class SearchInitial extends SearchState {}
/// SearchLoading class
class SearchLoading extends SearchState {}
/// SearchError class
class SearchError extends SearchState {
  /// SearchError constructor
  SearchError(this.message);
  /// SearchError constructor
  final String message;
  @override
  List<Object?> get props => [message];
}
/// SearchLoaded class
class SearchLoaded extends SearchState {
  /// SearchLoaded constructor
  SearchLoaded( {required this.searchResults});
/// SearchLoaded constructor
  final List<Merchant> searchResults;
  @override
  List<Object?> get props => [searchResults];
}
/// CategoryState class
abstract class CategoryState extends Equatable{
  @override
  List<Object?> get props => [];
}
/// InitialCategories class
class InitialCategories extends CategoryState {}
/// LoadingCategories class
class LoadingCategories extends CategoryState {}
/// LoadedCategories class
class LoadedCategories extends CategoryState {
  /// LoadedCategories constructor
  LoadedCategories(this.categories, this.selectedCategory);
  /// LoadedCategories constructor
  final List<Category> categories;
  /// LoadedCategories constructor
  final int? selectedCategory;
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
/// ErrorCategories class
class ErrorCategories extends CategoryState {
  /// ErrorCategories constructor
  ErrorCategories(this.message);
  /// ErrorCategories constructor
  final String message;
  @override
  List<Object?> get props => [message];
}
