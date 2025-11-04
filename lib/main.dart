import 'package:association_appli/core/di/get_it.dart';
import 'package:association_appli/presentation/pages/introduction_page.dart';
import 'package:association_appli/presentation/pages/login_signup/create_account_page.dart';
import 'package:association_appli/presentation/pages/members/create_member_page.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/providers/single_member_provider.dart';
import 'package:association_appli/presentation/providers/user_providers.dart';
import 'package:association_appli/presentation/routes/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbPath = await getDatabasesPath();
  await deleteDatabase(join(dbPath, 'AssocitionDB.db'));
  print("✅ Ancienne base supprimée avec succès");
  await setup();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<UserProviders>()),
        ChangeNotifierProvider(create: (_) => getIt<SingleMemberProvider>()),
        ChangeNotifierProvider(
          create: (_) => getIt<MemberProviders>()..getMembers(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: PageRoutes.createMember,
      routes: PageRoutes.routes,
      home: const CreateMemberPage(),
    );
  }
}
