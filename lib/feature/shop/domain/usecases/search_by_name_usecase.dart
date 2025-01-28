import 'package:dartz/dartz.dart';
import 'package:iman_invest/core/exceptions/failures.dart';
import 'package:iman_invest/core/utils/distance_calculator_function.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';

import '../../../../core/utils/is_invalid_merchant.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/repository/shop_repository_implementation.dart';
import '../repository/shop_repository.dart';

class SearchByNameUseCase
    extends UseCase<Either<Failure, List<Merchant>>, SearchParams> {
  final ShopRepository _shopRepository = ShopRepositoryImplementation();

  SearchByNameUseCase();

  @override
  Future<Either<Failure, List<Merchant>>> call(SearchParams params) async {
    final data = await _shopRepository.search(params.query, params.categoryId);
    final Either<Failure, List<Merchant>> result = data.fold((failure) {
      return Left(failure);
    }, (merchants) {
      merchants.removeWhere(isInvalidMerchant);
      return Right(sortMerchantsByDistance(params.userLocation, merchants,
          doNotSort: true));
    });
    return result;
  }
}
