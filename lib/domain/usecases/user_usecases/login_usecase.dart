import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/user_entity.dart';
import 'package:association_appli/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase {
  final UserRepository repository;
  LoginUsecase({required this.repository});
  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) {
    print(" =====>>>> loginUsecase is calling ");
    return repository.loginUser(email: email, password: password);
  }
}
