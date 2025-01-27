import 'package:iman_invest/feature/shop/data/models/merchant.dart';

import '../../data/models/category.dart';
import '../../data/models/data.dart';

abstract class ShopRepository {
  Future<Data> getBanners();
  Future<List<Category>> getCategories();
  Future<List<Merchant>> getPartners();
  Future<List<Merchant>> search(String query, String categoryId);
}
