// ignore_for_file: unused_element
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseHelper {
  static final AppDatabaseHelper instance = AppDatabaseHelper._init();
  AppDatabaseHelper._init();
  final int? version = 7;
  static Database? _database;

  Future<Database?> getDatabase() async {
    if (_database != null) return _database;
    _database = await _initDB('AssociationDB.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: version,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(createTableUser);
    await db.execute(createTableMember);
    await db.execute(createTableActivity);
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS users');
    await db.execute('DROP TABLE IF EXISTS members');
    await db.execute('DROP TABLE IF EXISTS activity');
    await db.execute(createTableUser);
    await db.execute(createTableMember);
    await db.execute(createTableActivity);
  }

  final String tableUser = 'users';
  final String userId = 'user_id';
  final String userName = 'user_name';
  final String userEmail = 'user_email';
  final String userPassword = 'user_password';

  late final String createTableUser = '''
CREATE TABLE $tableUser(
$userId INTEGER PRIMARY KEY AUTOINCREMENT,
$userName TEXT,
$userEmail TEXT,
$userPassword TEXT
)
''';

  final String tableMember = 'members';
  final String columnId = 'id';
  final String columnFullName = 'full_name';
  final String columnGenre = 'genre';
  final String columnCountry = 'country';
  final String columnCinNumber = 'cin_number';
  final String columnPhoneNumber = 'phone_number';
  final String columnFaculty = 'faculty';
  final String columnStudentCardNumber = 'student_card_number';
  final String columnDistrict = 'district';
  final String columnStatus = 'status';
  final String columnMemberResponsability = 'responsability';
  final String columnMemberShipFree = 'member_ship_free';
  final String columnMemberProducts = 'products';

  late final String createTableMember = '''
 CREATE TABLE $tableMember (
 $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
 $columnFullName TEXT NOT NULL, 
 $columnGenre TEXT NOT NULL, 
 $columnCountry TEXT NOT NULL,
 $columnCinNumber INTEGER, 
 $columnPhoneNumber INTEGER NOT NULL,
 $columnFaculty TEXT,
 $columnStudentCardNumber TEXT,
 $columnDistrict TEXT NOT NULL,
 $columnStatus TEXT NOT NULL,
 $columnMemberResponsability TEXT,
 $columnMemberShipFree INTEGER,
 $columnMemberProducts TEXT
 )

''';

  final String tableActivity = 'activity';
  final String columnActivityId = 'activity_id';
  final String columnStartDate = 'start_date';
  final String columnEndDate = 'end_date';

  late final String createTableActivity = '''
CREATE TABLE $tableActivity(
$columnActivityId INTEGER PRIMARY KEY AUTOINCREMENT,
$columnStartDate DATETIME,
$columnEndDate DATETIME
)

''';

  final String tableProducts = 'products';
  final String columnProductId = 'product_id';
  final String columnMemberId = 'member_id'; // cle etranger
  final String columnProductName = 'name';
  final String columnProductPrice = 'price';
  final String columnProductTicketNumber = 'ticket_number';
  final String columnProductRequiredTicket = 'required_ticket';
  final String columnProductDate = 'date';
  final String columnProductPayed = 'is_payed';
}
