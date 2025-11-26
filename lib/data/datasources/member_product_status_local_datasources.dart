import 'package:association_appli/data/datasources/app_database_helper.dart';
import 'package:association_appli/data/models/member_product_status_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class MemberProductStatusLocalDatasource {
  Future<void> saveStatus({required MemberProductStatusModel status});
  Future<List<MemberProductStatusModel>> getStatusByProductId({
    required int productId,
  });
  Future<void> updatePaymentStatus({
    required int statusId,
    required bool isPayed,
  });
}

class MemberProductStatusLocalDatasourceImpl
    implements MemberProductStatusLocalDatasource {
  final AppDatabaseHelper _helper = AppDatabaseHelper.instance;
  Future<Database?> get _database async => await _helper.getDatabase();

  @override
  Future<void> saveStatus({required MemberProductStatusModel status}) async {
    final database = await _database;
    database!.insert(
      _helper.tableMemberProductStatus,
      status.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<MemberProductStatusModel>> getStatusByProductId({
    required int productId,
  }) async {
    final database = await _database;
    var result = await database!.query(
      _helper.tableMemberProductStatus,
      where: '${_helper.columnMPSActivityProductIdFK} = ?',
      whereArgs: [productId],
    );
    var statusByProduct = result.map(
      (memberProduct) => MemberProductStatusModel.fromJson(memberProduct),
    );
    return statusByProduct.toList();
  }

  @override
  Future<void> updatePaymentStatus({
    required int statusId,
    required bool isPayed,
  }) async {
    final database = await _database;
    database!.update(
      _helper.tableMemberProductStatus,
      {_helper.columnMPSIsPayed: isPayed ? 1 : 0},
      where: '${_helper.columnMPSId} = ?',
      whereArgs: [statusId],
    );
  }
}
