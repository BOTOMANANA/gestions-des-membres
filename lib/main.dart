// ignore_for_file: avoid_print, unused_element
import 'package:association_appli/core/di/get_it.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/pages/main_navigation_page.dart';
import 'package:association_appli/presentation/providers/activity_provider.dart';
import 'package:association_appli/presentation/providers/generate_pdf_providers.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/providers/single_member_provider.dart';
import 'package:association_appli/presentation/providers/theme_notifier.dart';
import 'package:association_appli/presentation/providers/user_providers.dart';
import 'package:association_appli/presentation/routes/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // _cleanupDatabaseArtifacts();
  await setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<ThemeNotifier>()),
        ChangeNotifierProvider(create: (_) => getIt<UserProviders>()),
        ChangeNotifierProvider(create: (_) => getIt<SingleMemberProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<MemberProviders>()),
        ChangeNotifierProvider(create: (_) => getIt<ActivityProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<GeneratePdfProviders>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: LightThemeColors.colorPrimary,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo),
    );
    final darkTheme = ThemeData(brightness: Brightness.dark);

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: PageRoutes.mainNavigationBar,
      routes: PageRoutes.routes,
      home: const MainNavigationPage(),
    );
  }
}

//Nettoie les fichiers de base de données local.
Future<void> _cleanupDatabaseArtifacts() async {
  final dbPath = await getDatabasesPath();
  final fullPath = join(dbPath, 'AssociationDB.db');
  await deleteDatabase(fullPath);
  print("✅ Ancienne base supprimée avec succès");
  print("✅ Base supprimée : $fullPath");
}
