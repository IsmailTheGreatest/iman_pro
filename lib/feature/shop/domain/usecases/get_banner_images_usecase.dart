import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/repository/shop_repository_implementation.dart';
import '../repository/shop_repository.dart';

class GetBannerImages extends UseCase<Either<Failure, List<String>>, NoParams> {
  final ShopRepository repository = ShopRepositoryImplementation();

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    final data = await repository.getBanners();

    final Either<Failure, List<String>> result = data.fold((failure) {
      return Left(failure);
    }, (data) {
      final List<String> images = [];
      for (int i = 0; i < data.list.length; i++) {
        images.add(data.list[i].attributes.uz.url);
      }
      return Right(images);
    });
    return result;
  }
}
