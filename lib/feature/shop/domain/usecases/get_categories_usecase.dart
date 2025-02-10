import 'package:dartz/dartz.dart';
import 'package:iman_invest/core/exceptions/failures.dart';
import 'package:iman_invest/core/usecase/usecase.dart';
import 'package:iman_invest/feature/shop/data/models/category.dart';
import 'package:iman_invest/feature/shop/data/repository/shop_repository_implementation.dart';
import 'package:iman_invest/feature/shop/domain/repository/shop_repository.dart';

/// GetCategoriesUseCase class
class GetCategoriesUseCase
    with UseCase<Either<Failure, List<Category>>, NoParams> {
  final ShopRepository _shopRepository = ShopRepositoryImplementation();

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    final data = await _shopRepository.getCategories();
    final result = data.fold<Either<Failure, List<Category>>>((failure) {
      return Left(failure);
    }, (categories) {
      for (final category in categories) {
        if (category.banner == '') {
          categories
            ..remove(category)
            ..add(category);
        }
      }
      return Right(categories);
    });
    return result;
  }
}
