
import 'package:iman_invest/core/utils/distance_calculator_function.dart';
import 'package:iman_invest/core/utils/is_invalid_merchant.dart';

import '../../../../core/usecase/usecase.dart';
import '../../data/models/app_lat_long.dart';
import '../../data/models/merchant.dart';
import '../../data/repository/shop_repository_implementation.dart';
import '../repository/shop_repository.dart';

class GetPartnersUseCase extends UseCase<List<Merchant>, AppLatLong> {
  final ShopRepository _shopRepository = ShopRepositoryImplementation();

  GetPartnersUseCase();

  @override
  Future<List<Merchant>> call(AppLatLong params) async {
      final merchants = await _shopRepository.getPartners();
      merchants.removeWhere(isInvalidMerchant);
    return  sortMerchantsByDistance(params, merchants, doNotSort: true);
  }
}
