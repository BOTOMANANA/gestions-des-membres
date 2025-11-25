import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/data/datasources/product_local_datasources.dart';
import 'package:association_appli/data/models/product_model.dart';
import 'package:association_appli/domain/entities/product_entity.dart';
import 'package:association_appli/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDatasources datasources;
  ProductRepositoryImpl({required this.datasources});

  @override
  Future<Either<Failure, void>> createProduct({
    required ProductEntity productEntity,
  }) async {
    try {
      await datasources.insertProduct(
        ProductModel.fromEntity(productEntity: productEntity),
      );
      return Right(null);
    } catch (e) {
      return Left(failure(error: 'error to insert product $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct({required int id}) async {
    try {
      await datasources.deleteProduct(id: id);
      return Right(null);
    } catch (e) {
      return Left(failure(error: ' error to delete product$e'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsForActivity({
    required int activityId,
  }) async {
    try {
      final products = await datasources.getProductsByActivityId(activityId);
      return Right(products);
    } catch (e) {
      return Left(failure(error: 'error to display product $e'));
    }
  }
}
