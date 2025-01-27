import 'package:iman_invest/core/utils/distance_calculator_function.dart';
import 'package:iman_invest/feature/shop/data/models/merchant.dart';

import '../../../../core/utils/is_invalid_merchant.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/repository/shop_repository_implementation.dart';
import '../repository/shop_repository.dart';

class SearchByNameUseCase  extends UseCase<List<Merchant>, SearchParams> {
  final ShopRepository _shopRepository= ShopRepositoryImplementation();

  SearchByNameUseCase();

  @override
  Future<List<Merchant>> call( SearchParams params ) async {
    List<Merchant> searchResults = await _shopRepository.search(params.query, params.categoryId);
    searchResults.removeWhere(isInvalidMerchant);
    return sortMerchantsByDistance(params.userLocation, searchResults, doNotSort: true);
  }

}

