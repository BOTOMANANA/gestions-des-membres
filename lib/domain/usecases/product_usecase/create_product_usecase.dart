// ignore_for_file: avoid_print

import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/product_entity.dart';
import 'package:association_appli/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class CreateProductUseCase {
  final ProductRepository repository;

  CreateProductUseCase({required this.repository});

  Future<Either<Failure, void>> call({
    required ProductEntity productEntity,
  }) async {
    print("========== create usecase execut correctelly");
    return repository.createProduct(productEntity: productEntity);
  }
}
