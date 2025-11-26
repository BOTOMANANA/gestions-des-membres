import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/data/datasources/association_local_datasources.dart';
import 'package:association_appli/data/models/association_model.dart';
import 'package:association_appli/domain/entities/association_entity.dart';
import 'package:association_appli/domain/repositories/association_repository.dart';

import 'package:dartz/dartz.dart';

class AssociationRepositoryImpl extends AssociationRepository {
  AssociationLocalDatasources localDatasources;
  AssociationRepositoryImpl({required this.localDatasources});

  @override
  Future<Either<Failure, void>> createAssociation({
    required AssociationEntity associationEntity,
  }) async {
    try {
      await localDatasources.saveAssociation(
        associationModel: AssociationModel.fromEntity(
          association: associationEntity,
        ),
      );
      return Right(null);
    } catch (e) {
      return Left(failure(error: 'error to insert association'));
    }
  }

  @override
  Future<Either<Failure, AssociationEntity>> getAssociation() async {
    try {
      var asssociation = await localDatasources.fetchLocalAssociation();
      return Right(asssociation);
    } catch (e) {
      return Left(failure(error: 'error to load association'));
    }
  }
}
