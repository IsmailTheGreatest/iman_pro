import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:iman_invest/core/exceptions/failures.dart';
import 'package:iman_invest/feature/shop/data/datasource/network_datasource.dart';
import 'package:iman_invest/feature/shop/data/models/category.dart';
import 'package:iman_invest/feature/shop/data/models/data.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';
import 'package:iman_invest/feature/shop/domain/repository/shop_repository.dart';

///
class ShopRepositoryImplementation implements ShopRepository {
  ///
  final Datasource datasource = NetworkDatasource();

  @override
  Future<Either<Failure, Data>> getBanners() async {
    try {
      final data = await datasource.getBanners();

      return Right(data);
    } on DioException catch (e) {

      final failure = DioExceptionMapper.mapDioException(e);
      return Left(failure);
    }  on Exception catch (e) {

      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final categories = await datasource.getCategories();
      return Right(categories);
    } on DioException catch (e) {
      final failure = DioExceptionMapper.mapDioException(e);
      return Left(failure);
    } on Exception catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Merchant>>> getPartners() async {
    try {
      final partners = await datasource.getPartners();
      return Right(partners);
    } on DioException catch (e) {
      final failure = DioExceptionMapper.mapDioException(e);
      return Left(failure);
    } on Exception catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Merchant>>> search(
    String query,
    String categoryId,
  ) async {
    try {
      final searchResults = await datasource.search(query, categoryId);
      return Right(searchResults);
    } on DioException catch (e) {
      final failure = DioExceptionMapper.mapDioException(e);
      return Left(failure);
    } on Exception catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
