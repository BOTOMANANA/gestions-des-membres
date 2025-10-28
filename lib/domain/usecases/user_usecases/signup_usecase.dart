import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/user_entity.dart';
import 'package:association_appli/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class SignupUsecase {
  final UserRepository repository;
  SignupUsecase({required this.repository});
  Future<Either<Failure, void>> call({required UserEntity userEntity}) {
    return repository.signupUser(userEntity: userEntity);
  }
}
