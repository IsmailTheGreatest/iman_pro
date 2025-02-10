import 'package:dio/dio.dart';
import 'package:iman_invest/core/config/api_config.dart';
import 'package:iman_invest/core/exceptions/exceptions.dart';
import 'package:iman_invest/core/network/dio_client.dart';
import 'package:iman_invest/feature/shop/data/models/category.dart';
import 'package:iman_invest/feature/shop/data/models/data.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';

/// Datasource for fetching data from network
abstract class Datasource {
  /// Fetches banners from network
  Future<Data> getBanners();

  /// Fetches categories from network
  Future<List<Category>> getCategories();

  /// Fetches partners from network
  Future<List<Merchant>> getPartners();

  /// Searches for partners by name and category
  Future<List<Merchant>> search(String query, String categoryId);
}

/// Implementation of [Datasource] for fetching data from network
class NetworkDatasource implements Datasource {
  /// Dio client for making network requests
  final dio = DioClient();

  @override
  Future<Data> getBanners() async {
    try {
      final response = await dio.get(
        ApiClass.getBannerEndpoint,
        queryParameters: {
          'limit': 1000,
        },
      );
      if (response.statusCode == 200) {
        final data = (response.data as Map<String, dynamic>)['data']
            as Map<String, dynamic>?;

        if (data == null) {
          throw const ParsingException('Parsing Exception: Data is null');
        }
        return Data.fromJson(
          data,
        );
      } else {
        throw ServerException(response.statusCode);
      }
    } on DioException {
      rethrow;
    } on FormatException catch (e) {
      throw ParsingException('Parsing Exception: ${e.message}');
    } catch (e) {
      throw UnknownException('Exception: $e');
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      final response = await dio.get(
        ApiClass.getCategoriesEndpoint,
        queryParameters: {
          'limit': 1000,
        },
      );
      if (response.statusCode == 200) {
        final list = (response.data as Map<String, dynamic>)['list'];
        if (list == null || list is! List) {
          throw const ParsingException(
            'Parsing Exception: List is null or not a list',
          );
        }
        return list
            .map((item) => Category.fromJson(item as Map<String, dynamic>))
            .toList()
            .cast<Category>();
      } else {
        throw ServerException(response.statusCode);
      }
    } on DioException {
      rethrow;
    } on FormatException catch (e) {
      throw ParsingException('Parsing Exception: ${e.message}');
    } catch (e) {
      throw UnknownException('Exception: $e');
    }
  }

  @override
  Future<List<Merchant>> getPartners() async {
    try {
      final response = await dio.get(
        ApiClass.getBranchesEndpoint,
        queryParameters: {
          'limit': 1000,
        },
      );
      if (response.statusCode == 200) {
        final list = ((response.data as Map<String, dynamic>)['data']
            as Map<String, dynamic>)['list'] as List<dynamic>?;

        if (list == null ) {
          throw const ParsingException(
            'Parsing Exception: List is null or not a list',
          );
        }
        return list
            .map((item) => Merchant.fromJson(item as Map<String, dynamic>))
            .toList()
            .cast<Merchant>();
      } else {
        throw ServerException(response.statusCode);
      }
    } on DioException {
      rethrow;
    } on FormatException catch (e) {
      throw ParsingException('Parsing Exception: ${e.message}');
    } catch (e) {
      throw UnknownException('Exception: $e');
    }
  }

  @override
  Future<List<Merchant>> search(String query, String categoryId) async {
    try {
      final response = await dio.get(
        ApiClass.getBranchesEndpoint,
        queryParameters: {
          'name': query,
          'category_id': categoryId,
          'limit': 1000,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        if (data == null) {
          throw const ParsingException('Parsing Exception: Data is null');
        }
        final list =
            (data['data'] as Map<String, dynamic>?)?['list'] as dynamic;
        if (list == null || list is! List) {
          throw const ParsingException(
            'Parsing Exception: List is null or not a list',
          );
        }
        return list
            .map((item) => Merchant.fromJson(item as Map<String, dynamic>))
            .toList()
            .cast<Merchant>();
      } else {
        throw ServerException(response.statusCode);
      }
    } on DioException {
      rethrow;
    } on FormatException catch (e) {
      throw ParsingException('Parsing Exception: ${e.message}');
    } catch (e) {
      throw UnknownException('Exception: $e');
    }
  }
}
