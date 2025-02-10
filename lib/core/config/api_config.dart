import 'package:flutter_dotenv/flutter_dotenv.dart';
///
class ApiClass {
  ///
  static String get baseUrl {
    final url = dotenv.env['BASE_URL'];
    if (url != null) {
      return url;
    } else {
      throw Exception('BASE_URL is not defined in .env file');
    }
  }

  ///
  static String get apiKey {
    final url = dotenv.env['API_KEY'];
    if (url != null) {
      return url;
    } else {
      throw Exception('API_KEY is not defined in .env file');
    }
  }

  ///
  static const String getBannerEndpoint = '/v1/content/banners';
  ///
  static const String getCategoriesEndpoint = '/v1/categories';
  ///
  static const String getBranchesEndpoint = '/v1/merchants/branches';


}
