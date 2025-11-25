// ignore_for_file: avoid_print

import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteProductUsecase {
  final ProductRepository repository;

  DeleteProductUsecase({required this.repository});

  Future<Either<Failure, void>> call({required int id}) async {
    print("========= delete product usecase execute");
    return repository.deleteProduct(id: id);
  }
}
