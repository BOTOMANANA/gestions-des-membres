// ignore_for_file: unused_element
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseHelper {
  static final AppDatabaseHelper instance = AppDatabaseHelper._init();
  AppDatabaseHelper._init();
  final int? databaseVersion = 17;
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
      version: databaseVersion,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(createTableUser);
    await db.execute(createTableMember);
    await db.execute(createTableActivity);
    await db.execute(createTableActivityProducts);
    await db.execute(createTableMemberActivity);
    await db.execute(createTableMemberProductStatus);
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS users');
    await db.execute('DROP TABLE IF EXISTS members');
    await db.execute('DROP TABLE IF EXISTS activities');
    await db.execute('DROP TABLE IF EXISTS activity_products');
    await db.execute('DROP TABLE IF EXISTS member_activities');
    await db.execute('DROP TABLE IF EXISTS member_product_status');
    await _createDB(db, newVersion);
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
  final String columnMemberId = 'id';
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
  final String columnCreatedAt = 'created_at';

  late final String createTableMember = '''
  CREATE TABLE $tableMember (
  $columnMemberId INTEGER PRIMARY KEY AUTOINCREMENT, 
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
  $columnCreatedAt TEXT NOT NULL
  )
  ''';

  final String tableActivity = 'activities';
  final String columnActivityId = 'id';
  final String columnActivityName = 'name';
  final String columnStartDate = 'start_date';
  final String columnEndDate = 'end_date';
  final String columnLocation = 'location';

  late final String createTableActivity = '''
  CREATE TABLE $tableActivity(
  $columnActivityId INTEGER PRIMARY KEY AUTOINCREMENT,
  $columnActivityName TEXT NOT NULL,
  $columnStartDate TEXT NOT NULL,
  $columnEndDate TEXT NOT NULL,
  $columnLocation TEXT NOT NULL
  )
  ''';

  //(Produits définis par l'activité)
  //  activity_id : Clé étrangère vers activities
  final String tableActivityProducts = 'activity_products';
  final String columnActivityProductId = 'id';
  final String columnAPActivityIdFK = 'activity_id';
  final String columnAPProductName = 'name';
  final String columnAPProductPrice = 'price';
  final String columnAPProductRequiredTicket = 'required_tickets';
  final String columnAPProductDate = 'date';

  late final String createTableActivityProducts = '''
  CREATE TABLE $tableActivityProducts(
  $columnActivityProductId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $columnAPActivityIdFK INTERGER NOT NULL,
  $columnAPProductName TEXT NOT NULL,
  $columnAPProductPrice REAL NOT NULL, 
  $columnAPProductRequiredTicket INTEGER NOT NULL, 
  $columnAPProductDate TEXT, 
  FOREIGN KEY ($columnAPActivityIdFK) REFERENCES $tableActivity($columnActivityId) ON DELETE CASCADE
  )
  ''';

  // TABLE DE (Liaison Membre-Activité) Indique si un membre participe à une activité.
  // UNIQUE -- Empêche l'inscription double EXEMPLE (2, 1) , (2, 1) erreur

  final String tableMemberActivity = 'member_activities';
  final String columnMemberActivityId = 'id';
  final String columnMemberActivityMemberIdFK = 'member_id';
  final String columnMemberActivityActivityIdFK = 'activity_id';

  late final String createTableMemberActivity = '''   
  CREATE TABLE $tableMemberActivity( 
  $columnMemberActivityId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $columnMemberActivityMemberIdFK INTEGER NOT NULL,
  $columnMemberActivityActivityIdFK INTEGER NOT NULL,
  UNIQUE($columnMemberActivityMemberIdFK, $columnMemberActivityActivityIdFK), 
  FOREIGN KEY ($columnMemberActivityMemberIdFK) REFERENCES $tableMember($columnMemberId) ON DELETE CASCADE,
  FOREIGN KEY ($columnMemberActivityActivityIdFK) REFERENCES $tableActivity($columnActivityId) ON DELETE CASCADE
  )
''';

  final String tableMemberProductStatus = 'member_product_status';
  final String columnMPSId = 'id';
  final String columnMPSActivityProductIdFK = 'activity_product_id';
  final String columnMPSMemberIdFK = 'member_id';
  final String columnMPSTicketNumber = 'tickes_number';
  final String columnMPSIsPayed = 'is_payed';

  late final String createTableMemberProductStatus = '''
  CREATE TABLE $tableMemberProductStatus(
  $columnMPSId INTEGER PRIMARY KEY AUTOINCREMENT,
  $columnMPSActivityProductIdFK INTEGER NOT NULL,
  $columnMPSMemberIdFK INTEGER NOT NULL,
  $columnMPSTicketNumber INTEGER,
  $columnMPSIsPayed INTEGER NOT NULL, 
  UNIQUE($columnMPSMemberIdFK, $columnMPSActivityProductIdFK),
  FOREIGN KEY ($columnMPSActivityProductIdFK) REFERENCES $tableActivityProducts($columnActivityProductId) ON DELETE CASCADE
  FOREIGN KEY ($columnMPSMemberIdFK) REFERENCES $tableMember($columnMemberId) ON DELETE CASCADE
  )
''';
}
