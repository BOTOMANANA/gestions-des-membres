import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, void>> addProductToMember({
    required int memberId,
    required ProductEntity productEntity,
  });
}
