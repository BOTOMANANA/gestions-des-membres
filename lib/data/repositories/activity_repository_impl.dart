import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/data/datasources/activity_local_datasources.dart';
import 'package:association_appli/data/models/activity_model.dart';
import 'package:association_appli/domain/entities/activity_entity.dart';
import 'package:association_appli/domain/repositories/activity_repository.dart';
import 'package:dartz/dartz.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityLocalDatasources activityLocalDatasources;
  ActivityRepositoryImpl({required this.activityLocalDatasources});

  @override
  Future<Either<Failure, void>> createActivityRepository({
    required ActivityEntity activityEntity,
  }) async {
    try {
      await activityLocalDatasources.createActity(
        activityModel: ActivityModel.fromEntity(activityEntity: activityEntity),
      );
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Failure to create activity'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteActivityRepository({
    required int id,
  }) async {
    try {
      await activityLocalDatasources.deleteActivity(id: id);
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'failure to delete activity'));
    }
  }

  @override
  Future<Either<Failure, List<ActivityEntity>>>
  getAllActivityRepository() async {
    try {
      return Right(await activityLocalDatasources.getAllActivity());
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'failure to get all activity'));
    }
  }
}
