import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> signupUser({required UserEntity userEntity});
  Future<Either<Failure, UserEntity>> loginUser({
    required String email,
    required String password,
  });
}
