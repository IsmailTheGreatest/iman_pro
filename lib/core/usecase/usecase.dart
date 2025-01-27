
import 'package:iman_invest/feature/shop/data/models/app_lat_long.dart';

abstract class UseCase<Type, Params> {
  Future< Type> call(Params params);
}
class NoParams {}
class SearchParams{
  final String query;
  final String categoryId;
  final AppLatLong userLocation;

  SearchParams(this.query, this.categoryId, this.userLocation);
}