import '../../../../core/exceptions/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/category.dart';
import '../../data/repository/shop_repository_implementation.dart';
import '../repository/shop_repository.dart';
import 'package:dartz/dartz.dart';


class GetCategoriesUseCase extends UseCase<Either<Failure,List<Category>>, NoParams> {
  final ShopRepository _shopRepository = ShopRepositoryImplementation();

  @override
  Future<Either<Failure,List<Category>>> call(NoParams params) async {
    var data = await _shopRepository.getCategories();
    final Either<Failure,List<Category>> result = data.fold((failure) {
      return Left(failure);
    }, (categories) {
      Category? temp;
      for (var category in categories) {
        if (category.banner == '') {
          temp = category;
          categories.remove(category);
          categories.add(temp);
        }
      }
      return Right(categories);
    });
  return result;
  }
}
