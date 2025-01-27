import 'package:iman_invest/feature/shop/data/models/category.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';
import 'package:iman_invest/core/network/dio_client.dart';

import '../models/data.dart';
import 'package:iman_invest/core/config/api_config.dart';
abstract class Datasource {
  Future<Data> getBanners();
  Future<List<Category>> getCategories();
  Future<List<Merchant>> getPartners();
  Future<List<Merchant>> search(String query, String categoryId);
}
class NetworkDatasource implements Datasource {
  final dio = DioClient();

  @override
  Future<Data> getBanners() async {
    final response =
    await dio.get(ApiClass.getBannerEndpoint, queryParameters: {
      'limit': 1000,
    });
    if (response.statusCode == 200) {
      return Data.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    final response =
    await dio.get(ApiClass.getCategoriesEndpoint, queryParameters: {
      'limit': 1000,
    });
    if (response.statusCode == 200) {
      return response.data['list']
          .map((item) => Category.fromJson(item))
          .toList()
          .cast<Category>();
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  Future<List<Merchant>> getPartners() async {
    final response =
    await dio.get(ApiClass.getBranchesEndpoint, queryParameters: {
      'limit': 1000,
    });
    if (response.statusCode == 200) {
      return response.data['data']['list']
          .map((item) => Merchant.fromJson(item))
          .toList()
          .cast<Merchant>();
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  Future<List<Merchant>> search(String query, String categoryId) async {
    final response =
    await dio.get(ApiClass.getBranchesEndpoint, queryParameters: {
      'name': query,
      'category_id': categoryId,
      'limit': 1000,
    });

    if (response.statusCode == 200) {
      return response.data['data']['list']
          .map((item) => Merchant.fromJson(item))
          .toList()
          .cast<Merchant>();
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
