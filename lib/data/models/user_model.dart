import 'package:association_appli/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.password,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'],
      name: json['user_name'],
      email: json['user_email'],
      password: json['user_password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'user_name': name,
      'user_email': email,
      'user_password': password,
    };
  }

  factory UserModel.fromEntity({required UserEntity user}) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      password: user.password,
    );
  }
}
