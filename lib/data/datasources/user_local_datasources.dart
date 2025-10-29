// ignore_for_file: avoid_print

import 'package:association_appli/data/datasources/app_database_helper.dart';
import 'package:association_appli/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class UserLocalDatasources {
  Future<void> signupUser({required UserModel userModel});
  Future<UserModel?> loginUser({
    required String email,
    required String password,
  });
}

class UserLocalDatasourcesImpl extends UserLocalDatasources {
  final AppDatabaseHelper _helper = AppDatabaseHelper.instance;

  Future<Database?> get _database async => await _helper.getDatabase();

  @override
  Future<void> signupUser({required UserModel userModel}) async {
    final database = await _database;

    final userConunt = await database?.rawQuery(
      'SELECT COUNT(*) as total FROM ${_helper.tableUser}',
    );
    int countUser = Sqflite.firstIntValue(userConunt!) ?? 0;

    if (countUser >= 100) {
      throw Exception(
        " ========== >>>>>>> Nombre maximum d'utilisateurs atteint (3).",
      );
    }
    try {
      await database?.insert(_helper.tableUser, userModel.toJson());
      print(
        " ===========>>>>>>>> Utilisateur inséré avec succès : ${userModel.email}<<<<<<<<=========",
      );
    } catch (e) {
      print(" =============.>>>>>>>>>❌ Erreur d'insertion utilisateur : $e");
    }
  }

  @override
  Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final database = await _database;
    try {
      final user = await database!.query(
        _helper.tableUser,
        where: 'user_email = ? AND user_password = ?',
        whereArgs: [email, password],
      );

      if (user.isNotEmpty) {
        print("[ =====>>>>>login Database is calling]");
        return UserModel.fromJson(user.first);
      } else {
        return null;
      }
    } catch (e) {
      print("Erreur lors du login: $e");
      rethrow;
    }
  }
}
