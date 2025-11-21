import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/activity_entity.dart';
import 'package:association_appli/domain/repositories/activity_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllAcitvityUsecase {
  ActivityRepository repository;
  GetAllAcitvityUsecase({required this.repository});
  Future<Either<Failure, List<ActivityEntity>>> call() async {
    return await repository.getAllActivityRepository();
  }
}
