import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/association_entity.dart';
import 'package:association_appli/domain/repositories/association_repository.dart';
import 'package:dartz/dartz.dart';

class GetAssociationUsecase {
  final AssociationRepository repository;

  GetAssociationUsecase({required this.repository});

  Future<Either<Failure, AssociationEntity>> call() async {
    return await repository.getAssociation();
  }
}
