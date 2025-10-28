// ignore_for_file: unused_element, avoid_print

import 'package:association_appli/data/datasources/app_database_helper.dart';
import 'package:association_appli/data/models/member_model.dart';
import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:sqflite/sqflite.dart';

abstract class MemberLocalDatasources {
  Future<List<MemberModel>> getAllMembers();
  Future<MemberModel> getMemberById({required int id});
  Future<int> getMemberCount();
  Future<List<MemberModel>> getMemberByStatus({
    required MemberStatus memberStatus,
  });
  Future<void> createMember({required MemberModel memberModel});
  Future<void> updateMember({required MemberModel memberModel});
  Future<void> deleteMember({required int id});
  Future<List<MemberModel>> searchMembers({required String fullName});
}

class MemberLocalDatasourcesImpl extends MemberLocalDatasources {
  final AppDatabaseHelper _helper = AppDatabaseHelper.instance;

  Future<Database?> get _database async => await _helper.getDatabase();

  @override
  Future<void> createMember({required MemberModel memberModel}) async {
    final database = await _database;
    await database?.insert(_helper.createTableMember, memberModel.toJson());
  }

  @override
  Future<void> deleteMember({required int id}) async {
    final database = await _database;
    await database?.delete(
      _helper.createTableMember,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<List<MemberModel>> getAllMembers() async {
    final database = await _database;
    try {
      var result = await database!.query(_helper.tableMember);
      print("Result from DB: $result");
      return result.map((value) => MemberModel.fromJson(value)).toList();
    } catch (e) {
      print("DB Error: $e");
      rethrow;
    }
  }

  @override
  Future<MemberModel> getMemberById({required int id}) async {
    final database = await _database;
    var result = await database?.query(
      _helper.createTableMember,
      where: "id = ?",
      whereArgs: [id],
    );
    return MemberModel.fromJson(result!.first);
  }

  @override
  Future<List<MemberModel>> searchMembers({required String fullName}) async {
    final database = await _database;
    //le lower? indique que je transforme miniscule tous Les lettres  dans la recherche
    String selection = "LOWER(${_helper.columnFullName}) LIKE LOWER(?)";
    List selectionArgs = [
      "$fullName%",
    ]; // je recherche par tout dans le nom et prenom de quelqun
    String orderBy = "${_helper.columnFullName} ASC";
    List<String> columns = [
      _helper.columnMemberId,
      _helper.columnFullName,
      _helper.columnCountry,
      _helper.columnCinNumber,
      _helper.columnPhoneNumber,
      _helper.columnFaculty,
      _helper.columnDistrict,
      _helper.columnStudentCardNumber,
      _helper.columnStatus,
      _helper.columnMemberShipFree,
      _helper.columnMemberProducts,
    ];
    var result = await database!.query(
      _helper.createTableMember,
      where: selection,
      whereArgs: selectionArgs,
      columns: columns,
      orderBy: orderBy,
    );
    return result.map((value) => MemberModel.fromJson(value)).toList();
  }

  @override
  Future<void> updateMember({required MemberModel memberModel}) async {
    final database = await _database;
    await database?.update(_helper.createTableMember, memberModel.toJson());
  }

  @override
  Future<List<MemberModel>> getMemberByStatus({
    required MemberStatus memberStatus,
  }) async {
    final database = await _database;
    String convertEnumStatus = memberStatus.toString().split('.').last;
    String request =
        'SELECT * FROM ${_helper.tableMember} WHERE ${_helper.columnStatus} = ?';
    var result = await database!.rawQuery(request, [convertEnumStatus]);
    return result.map((value) => MemberModel.fromJson(value)).toList();
  }

  @override
  Future<int> getMemberCount() async {
    final database = await _database;
    String request = 'SELECT COUNT(*)  as total FROM ${_helper.tableMember}';

    var result = await database!.rawQuery(request);
    int memberCounts = Sqflite.firstIntValue(result) ?? 0;
    return memberCounts;
  }
}
