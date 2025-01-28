import 'package:dio/dio.dart';
import 'package:iman_invest/feature/shop/data/models/category.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';
import 'package:iman_invest/core/network/dio_client.dart';

import '../../../../core/exceptions/exceptions.dart';

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
    try {
      final response =
          await dio.get(ApiClass.getBannerEndpoint, queryParameters: {
        'limit': 1000,
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = response.data['data'];
        if (data == null) {
          throw const ParsingException("Parsing Exception: Data is null");
        }
        return Data.fromJson(data);
      } else {
        throw ServerException(response.statusCode);
      }
    } on DioException {
      rethrow;
    } on FormatException catch (e) {
      throw ParsingException("Parsing Exception: ${e.message}");
    } catch (e) {
      throw UnknownException("Exception: ${e.toString()}");
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      final response =
          await dio.get(ApiClass.getCategoriesEndpoint, queryParameters: {
        'limit': 1000,
      });
      if (response.statusCode == 200) {
        final list = response.data['list'];
        if (list == null || list is! List) {
          throw const ParsingException(
              "Parsing Exception: List is null or not a list");
        }
        return list
            .map((item) => Category.fromJson(item))
            .toList()
            .cast<Category>();
      } else {
        throw ServerException(response.statusCode!);
      }
    } on DioException {
      rethrow;
    } on FormatException catch (e) {
      throw ParsingException("Parsing Exception: ${e.message}");
    } catch (e) {
      throw UnknownException("Exception: ${e.toString()}");
    }
  }

  @override
  Future<List<Merchant>> getPartners() async {
    try {
      final response =
          await dio.get(ApiClass.getBranchesEndpoint, queryParameters: {
        'limit': 1000,
      });
      if (response.statusCode == 200) {
        final list = response.data['data']['list'];
        if (list == null || list is! List) {
          throw const ParsingException(
              "Parsing Exception: List is null or not a list");
        }
        return list
            .map((item) => Merchant.fromJson(item))
            .toList()
            .cast<Merchant>();
      } else {
        throw ServerException(response.statusCode);
      }
    } on DioException {
      rethrow;
    } on FormatException catch (e) {
      throw ParsingException("Parsing Exception: ${e.message}");
    } catch (e) {
      throw UnknownException("Exception: ${e.toString()}");
    }
  }

  @override
  Future<List<Merchant>> search(String query, String categoryId) async {
    try {
      final response =
          await dio.get(ApiClass.getBranchesEndpoint, queryParameters: {
        'name': query,
        'category_id': categoryId,
        'limit': 1000,
      });

      if (response.statusCode == 200) {
        final list = response.data['data']['list'];
        if (list == null || list is! List) {
          throw const ParsingException(
              "Parsing Exception: List is null or not a list");
        }
        return list
            .map((item) => Merchant.fromJson(item))
            .toList()
            .cast<Merchant>();
      } else {
        throw ServerException(response.statusCode);
      }
    } on DioException {
      rethrow;
    } on FormatException catch (e) {
      throw ParsingException("Parsing Exception: ${e.message}");
    } catch (e) {
      throw UnknownException("Exception: ${e.toString()}");
    }
  }
}
