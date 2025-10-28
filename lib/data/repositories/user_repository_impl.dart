import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/data/datasources/user_local_datasources.dart';
import 'package:association_appli/data/models/user_model.dart';
import 'package:association_appli/domain/entities/user_entity.dart';
import 'package:association_appli/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl extends UserRepository {
  UserLocalDatasources userLocalDatasources;
  UserRepositoryImpl({required this.userLocalDatasources});

  @override
  Future<Either<Failure, UserEntity>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      var user = await userLocalDatasources.loginUser(
        email: email,
        password: password,
      );

      if (user == null) {
        return Left(DatabaseFailure(errorMessage: "no user found in database"));
      }

      return Right(user);
    } catch (e) {
      return Left(
        DatabaseFailure(
          errorMessage: 'user error to recuperated from database',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> signupUser({
    required UserEntity userEntity,
  }) async {
    try {
      await userLocalDatasources.signupUser(
        userModel: UserModel.fromEntity(user: userEntity),
      );
      return Right(null);
    } catch (e) {
      return Left(
        DatabaseFailure(errorMessage: 'Sorry failure to create User'),
      );
    }
  }
}
