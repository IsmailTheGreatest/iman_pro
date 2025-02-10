import 'package:dartz/dartz.dart';
import 'package:iman_invest/core/exceptions/failures.dart';
import 'package:iman_invest/core/usecase/usecase.dart';
import 'package:iman_invest/core/utils/distance_calculator_function.dart';
import 'package:iman_invest/core/utils/is_invalid_merchant.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';
import 'package:iman_invest/feature/shop/data/repository/shop_repository_implementation.dart';
import 'package:iman_invest/feature/shop/domain/repository/shop_repository.dart';

/// SearchByNameUseCase class
class SearchByNameUseCase
    with UseCase<Either<Failure, List<Merchant>>, SearchParams> {
  /// SearchByNameUseCase constructor
  SearchByNameUseCase();

  final ShopRepository _shopRepository = ShopRepositoryImplementation();

  @override
  Future<Either<Failure, List<Merchant>>> call(SearchParams params) async {
    final data = await _shopRepository.search(params.query, params.categoryId);
    final result = data.fold<Either<Failure, List<Merchant>>>((failure) {
      return Left(failure);
    }, (merchants) {
      merchants.removeWhere(isInvalidMerchant);
      return Right(
        sortMerchantsByDistance(
          params.userLocation,
          merchants,
          doNotSort: true,
        ),
      );
    });
    return result;
  }
}
