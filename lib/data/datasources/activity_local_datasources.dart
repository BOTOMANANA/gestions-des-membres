import 'package:association_appli/data/datasources/app_database_helper.dart';
import 'package:association_appli/data/models/activity_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class ActivityLocalDatasources {
  Future<List<ActivityModel>> getAllActivity();
  Future<void> deleteActivity({required int id});
  Future<void> createActity({required ActivityModel activityModel});
}

class ActivityLocalDatasourcesImpl implements ActivityLocalDatasources {
  final AppDatabaseHelper _helper = AppDatabaseHelper.instance;

  Future<Database?> get _database async => await _helper.getDatabase();

  @override
  Future<void> createActity({required ActivityModel activityModel}) async {
    final database = await _database;
    database!.insert(_helper.tableActivity, activityModel.toJson());
  }

  @override
  Future<void> deleteActivity({required int id}) async {
    final database = await _database;
    database!.delete(_helper.tableActivity, where: 'id = ?');
  }

  @override
  Future<List<ActivityModel>> getAllActivity() async {
    final database = await _database;
    var result = await database!.query(_helper.tableActivity);
    return result.map((value) => ActivityModel.fromJson(value)).toList();
  }
}
