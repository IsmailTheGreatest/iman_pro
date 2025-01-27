import '../../../../core/usecase/usecase.dart';
import '../../data/models/category.dart';
import '../../data/repository/shop_repository_implementation.dart';
import '../repository/shop_repository.dart';

class GetCategoriesUseCase extends UseCase<List<Category>, NoParams> {
  final ShopRepository _shopRepository = ShopRepositoryImplementation();

  @override
  Future<List<Category>> call(NoParams params) async {
    Category? temp;
    var categories = await _shopRepository.getCategories();
    for (var category in categories) {
      if (category.banner == '') {
        temp = category;
        categories.remove(category);
        categories.add(temp);
      }
    }
    return categories;
  }
}
