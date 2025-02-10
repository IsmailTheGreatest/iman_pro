import 'package:dartz/dartz.dart';
import 'package:iman_invest/core/exceptions/failures.dart';
import 'package:iman_invest/feature/shop/data/models/category.dart';
import 'package:iman_invest/feature/shop/data/models/data.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';

///

abstract class ShopRepository {
  ///
  Future<Either<Failure, Data>> getBanners();

  ///
  Future<Either<Failure, List<Category>>> getCategories();

  ///
  Future<Either<Failure, List<Merchant>>> getPartners();

  ///
  Future<Either<Failure, List<Merchant>>> search(
    String query,
    String categoryId,
  );
}
