import 'package:dartz/dartz.dart';

import 'package:iman_invest/core/exceptions/failures.dart';
import 'package:iman_invest/core/usecase/usecase.dart';
import 'package:iman_invest/feature/shop/data/repository/shop_repository_implementation.dart';
import 'package:iman_invest/feature/shop/domain/repository/shop_repository.dart';

/// GetBannerImages class
class GetBannerImages
    implements UseCase<Either<Failure, List<String>>, NoParams> {
  /// GetBannerImages constructor
  final ShopRepository repository = ShopRepositoryImplementation();

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    final data = await repository.getBanners();

    final result = data.fold<Either<Failure, List<String>>>((failure) {
      return Left(failure);
    }, (data) {
      final images = <String>[];
      for (var i = 0; i < data.list.length; i++) {
        images.add(data.list[i].attributes.uz.url);
      }
      return Right(images);
    });
    return result;
  }
}
