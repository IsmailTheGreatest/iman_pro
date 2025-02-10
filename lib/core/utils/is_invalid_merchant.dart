import 'package:iman_invest/feature/shop/data/models/merchant.dart';
///
bool isInvalidMerchant(Merchant merchant) {
  return merchant.address.latitude == 0 ||
      merchant.address.longitude == 0 ||
      merchant.address.latitude < 0 ||
      merchant.address.longitude > 180 ||
      merchant.address.latitude > 90 ||
      merchant.address.longitude < 0;
}
