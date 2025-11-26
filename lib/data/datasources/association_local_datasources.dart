// ignore_for_file: avoid_print

import 'package:association_appli/data/datasources/app_database_helper.dart';
import 'package:association_appli/data/models/association_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class AssociationLocalDatasources {
  Future<void> saveAssociation({required AssociationModel associationModel});
  Future<AssociationModel> fetchLocalAssociation();
}

class AssociationLocalDatasourcesImpl extends AssociationLocalDatasources {
  final AppDatabaseHelper _dbHelper = AppDatabaseHelper.instance;

  Future<Database?> get _databaseInstance async =>
      await _dbHelper.getDatabase();

  @override
  Future<void> saveAssociation({
    required AssociationModel associationModel,
  }) async {
    final database = await _databaseInstance;
    await database?.insert(
      _dbHelper.tableAssociation,
      associationModel.toJson(),
    );
  }

  @override
  Future<AssociationModel> fetchLocalAssociation() async {
    final database = await _databaseInstance;
    final records = await database!.query(_dbHelper.tableAssociation);
    final record = records.first;
    return AssociationModel.fromJson(json: record);
  }
}
