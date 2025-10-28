import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/product_entity.dart';
import 'package:association_appli/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class AddProductToMember {
  ProductRepository repository;
  AddProductToMember({required this.repository});
  Future<Either<Failure, void>> call({
    required int memberId,
    required ProductEntity productEntity,
  }) async {
    return await repository.addProductToMember(
      memberId: memberId,
      productEntity: productEntity,
    );
  }
}
