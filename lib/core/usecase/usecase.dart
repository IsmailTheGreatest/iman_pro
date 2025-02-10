
import 'package:iman_invest/feature/shop/data/models/app_lat_long.dart';
/// UseCase abstract class
mixin UseCase<Type, Params> {
  /// UseCase abstract class call method
  Future< Type> call(Params params);
}
/// NoParams class
class NoParams {}
/// SearchParams class
class SearchParams{
/// SearchParams constructor
  SearchParams(this.query, this.categoryId, this.userLocation);
  /// SearchParams constructor
  final String query;
  /// SearchParams constructor
  final String categoryId;
  /// SearchParams constructor
  final AppLatLong userLocation;
}
