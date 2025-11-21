import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/repositories/activity_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteActivityUsecase {
  ActivityRepository repository;
  DeleteActivityUsecase({required this.repository});
  Future<Either<Failure, void>> call({required int id}) async {
    return await repository.deleteActivityRepository(id: id);
  }
}
