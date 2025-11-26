import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/association_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AssociationRepository {
  Future<Either<Failure, AssociationEntity>> getAssociation();
  Future<Either<Failure, void>> createAssociation({
    required AssociationEntity associationEntity,
  });
}
