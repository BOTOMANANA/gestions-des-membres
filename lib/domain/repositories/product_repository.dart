import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, void>> createProduct({
    required ProductEntity productEntity,
  });
  Future<Either<Failure, List<ProductEntity>>> getProductsForActivity({
    required int activityId,
  });
  Future<Either<Failure, void>> deleteProduct({required int id});
}
