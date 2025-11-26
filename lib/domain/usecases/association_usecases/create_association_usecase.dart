import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/association_entity.dart';
import 'package:association_appli/domain/repositories/association_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAssociationUsecase {
  final AssociationRepository repository;
  CreateAssociationUsecase({required this.repository});
  Future<Either<Failure, void>> call({
    required AssociationEntity association,
  }) async {
    return await repository.createAssociation(associationEntity: association);
  }
}
