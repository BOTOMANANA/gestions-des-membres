import 'package:association_appli/core/di/get_it.dart';
import 'package:association_appli/presentation/pages/main_navigation_page.dart';
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
  // final dbPath = await getDatabasesPath();
  // final fullPath = join(dbPath, 'AssociationDB.db');
  // await deleteDatabase(fullPath);
  // print("✅ Ancienne base supprimée avec succès");
  // print("✅ Base supprimée : $fullPath");

  await setup();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<UserProviders>()),
        ChangeNotifierProvider(create: (_) => getIt<SingleMemberProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<MemberProviders>()),
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
      initialRoute: PageRoutes.mainNavigationBar,
      routes: PageRoutes.routes,
      home: const MainNavigationPage(),
    );
  }
}
