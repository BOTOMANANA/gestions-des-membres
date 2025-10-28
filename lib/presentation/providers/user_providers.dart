import 'package:association_appli/domain/entities/user_entity.dart';
import 'package:association_appli/domain/usecases/user_usecases/login_usecase.dart';
import 'package:association_appli/domain/usecases/user_usecases/signup_usecase.dart';
import 'package:flutter/widgets.dart';

enum UserStatus { initial, error, loading, success }

class UserProviders with ChangeNotifier {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;
  UserProviders({required this.loginUsecase, required this.signupUsecase});

  UserStatus status = UserStatus.initial;
  String errorMessage = '';
  UserEntity? userEntity;

  void _setLoading() {
    status = UserStatus.loading;
    notifyListeners();
  }

  void signupUser({required UserEntity userEntity}) async {
    _setLoading();

    var user = await signupUsecase(userEntity: userEntity);
    user.fold(
      (failure) {
        status = UserStatus.error;
        errorMessage = failure.errorMessage;
        notifyListeners();
      },
      (_) {
        status = UserStatus.success;
        notifyListeners();
      },
    );
  }

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    _setLoading();

    var user = await loginUsecase(email: email, password: password);
    print('[loginProvider ] est bien appele');
    user.fold(
      (failure) {
        status = UserStatus.error;
        errorMessage = failure.errorMessage;
        print("Erreur ===============>>>>>>>>>: $errorMessage");
        notifyListeners();
      },
      (isUser) {
        status = UserStatus.success;
        userEntity = isUser;
        print('[loginProvider ] est bien appele');
        notifyListeners();
      },
    );
    return user.isRight();
  }
}
