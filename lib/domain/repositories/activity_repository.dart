import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/activity_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ActivityRepository {
  Future<Either<Failure, List<ActivityEntity>>> getAllActivityRepository();
  Future<Either<Failure, void>> deleteActivityRepository({required int id});
  Future<Either<Failure, void>> createActivityRepository({
    required ActivityEntity activityEntity,
  });
}
