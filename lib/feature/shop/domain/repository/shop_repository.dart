import 'package:iman_invest/feature/shop/data/models/merchant.dart';

import '../../../../core/exceptions/failures.dart';
import '../../data/models/category.dart';
import '../../data/models/data.dart';
import "package:dartz/dartz.dart";

abstract class ShopRepository {
  Future<Either<Failure, Data>> getBanners();

  Future<Either<Failure, List<Category>>> getCategories();

  Future<Either<Failure, List<Merchant>>> getPartners();

  Future<Either<Failure, List<Merchant>>> search(
      String query, String categoryId);
}
