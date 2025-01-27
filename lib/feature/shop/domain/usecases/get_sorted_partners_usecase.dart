import 'package:iman_invest/core/utils/is_invalid_merchant.dart';
import 'package:iman_invest/feature/shop/data/models/app_lat_long.dart';

import '../../../../core/usecase/usecase.dart';
import '../../data/models/merchant.dart';
import '../../data/repository/shop_repository_implementation.dart';
import '../repository/shop_repository.dart';
import 'package:iman_invest/core/utils/distance_calculator_function.dart';

class GetClosestPartnersUseCase extends UseCase<List<Merchant>, AppLatLong> {
  final ShopRepository _shopRepository = ShopRepositoryImplementation();



  @override
  Future<List<Merchant>> call(AppLatLong params) async {
    List<Merchant> merchants = await _shopRepository.getPartners();
    merchants.removeWhere(isInvalidMerchant);
    return  sortMerchantsByDistance(params, merchants, doNotSort: false);
  }
}
