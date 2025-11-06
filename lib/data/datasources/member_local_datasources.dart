// ignore_for_file: unused_element, avoid_print

import 'package:association_appli/data/datasources/app_database_helper.dart';
import 'package:association_appli/data/models/member_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class MemberLocalDatasources {
  Future<List<MemberModel>> getAllMembers();
  Future<MemberModel> getMemberById({required int id});
  Future<int> getMemberCount();
  Future<List<MemberModel>> getMemberByStatus({required String memberCategory});
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
    await database?.insert(_helper.tableMember, memberModel.toJson());
    print("======>>>📦 Member enregistré avec status: ${memberModel.category}");
  }

  @override
  Future<void> deleteMember({required int id}) async {
    final database = await _database;
    await database?.delete(
      _helper.tableMember,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<List<MemberModel>> getAllMembers() async {
    final database = await _database;
    try {
      var members = await database!.query(
        _helper.tableMember,
        orderBy: 'full_name ASC',
      );
      print("Result from DB: $members");
      return members.map((value) => MemberModel.fromJson(value)).toList();
    } catch (e) {
      print("DB Error: $e");
      rethrow;
    }
  }

  @override
  Future<MemberModel> getMemberById({required int id}) async {
    final database = await _database;
    var result = await database?.query(
      _helper.tableMember,
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
    List<String> columnsOfTable = [
      _helper.columnId,
      _helper.columnFullName,
      _helper.columnGenre,
      _helper.columnCountry,
      _helper.columnCinNumber,
      _helper.columnPhoneNumber,
      _helper.columnFaculty,
      _helper.columnDistrict,
      _helper.columnStudentCardNumber,
      _helper.columnStatus,
      _helper.columnMemberShipFree,
      _helper.columnCreatedAt,
      _helper.columnMemberProducts,
    ];
    var result = await database!.query(
      _helper.tableMember,
      where: selection,
      whereArgs: selectionArgs,
      columns: columnsOfTable,
      orderBy: orderBy,
    );
    return result.map((value) => MemberModel.fromJson(value)).toList();
  }

  @override
  Future<void> updateMember({required MemberModel memberModel}) async {
    final database = await _database;
    await database?.update(
      _helper.tableMember,
      memberModel.toJson(),
      where: 'id = ?',
      whereArgs: [memberModel.id],
    );
  }

  @override
  Future<List<MemberModel>> getMemberByStatus({
    required String memberCategory,
  }) async {
    final database = await _database;

    String request =
        'SELECT * FROM ${_helper.tableMember} WHERE ${_helper.columnStatus} = ? ORDER BY ${_helper.columnFullName} ASC';
    var result = await database!.rawQuery(request, [memberCategory]);
    print(
      " ====>>>🔍 getMemberByStatus('$memberCategory') → ${result.length} membres trouvés",
    );
    return result.map((members) => MemberModel.fromJson(members)).toList();
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
