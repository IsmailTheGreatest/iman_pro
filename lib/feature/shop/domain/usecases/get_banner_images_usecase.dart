import '../../../../core/usecase/usecase.dart';
import '../../data/repository/shop_repository_implementation.dart';
import '../repository/shop_repository.dart';

class GetBannerImages extends UseCase<List<String>, NoParams> {
  final ShopRepository repository = ShopRepositoryImplementation();
 @override
 Future<List<String>> call(NoParams params) async {
    final data = await repository.getBanners();
    final List<String> images = [];

   for (int i = 0; i < data.list.length; i++) {
      images.add(data.list[i].attributes.uz.url);
        }

    return images;
  }
}
