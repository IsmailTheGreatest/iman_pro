import 'package:iman_invest/feature/shop/data/models/category.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';
import 'package:iman_invest/feature/shop/domain/repository/shop_repository.dart';
import 'package:iman_invest/feature/shop/data/datasource/network_datasource.dart';
import '../models/data.dart';

class ShopRepositoryImplementation implements ShopRepository {
  final Datasource datasource = NetworkDatasource();

  @override
  Future<Data> getBanners() async {
    final data = await datasource.getBanners();
    return data;
  }

  @override
  Future<List<Category>> getCategories() async {
    final categories = await datasource.getCategories();
    return categories;
  }

  @override
  Future<List<Merchant>> getPartners() async {
    final partners = await datasource.getPartners();
    return partners;
  }

  @override
  Future<List<Merchant>> search(String query, String categoryId) async {
    final searchResults = await datasource.search(query, categoryId);
    return searchResults;
  }
}
