import 'package:dartz/dartz.dart';
import 'package:iman_invest/core/utils/distance_calculator_function.dart';
import 'package:iman_invest/core/utils/is_invalid_merchant.dart';

import '../../../../core/exceptions/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/app_lat_long.dart';
import '../../data/models/merchant.dart';
import '../../data/repository/shop_repository_implementation.dart';
import '../repository/shop_repository.dart';

class GetPartnersUseCase
    extends UseCase<Either<Failure, List<Merchant>>, AppLatLong> {
  final ShopRepository _shopRepository = ShopRepositoryImplementation();

  GetPartnersUseCase();

  @override
  Future<Either<Failure, List<Merchant>>> call(AppLatLong params) async {
    final data = await _shopRepository.getPartners();
    final Either<Failure, List<Merchant>> result = data.fold((failure) {
      return Left(failure);
    }, (merchants) {
      merchants.removeWhere(isInvalidMerchant);
      return Right(sortMerchantsByDistance(params, merchants, doNotSort: true));
    });
    return result;
  }
}
