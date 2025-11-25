// ignore_for_file: avoid_print

import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/product_entity.dart';
import 'package:association_appli/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductsForActivity {
  final ProductRepository repository;

  GetProductsForActivity({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call({
    required int activityId,
  }) async {
    print("========= get product for activity execute ");
    return repository.getProductsForActivity(activityId: activityId);
  }
}
