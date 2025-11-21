import 'package:association_appli/presentation/providers/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();
    final isDark = themeNotifier.isDarkMode;

    final toggleAction = context.read<ThemeNotifier>().toggleTheme;

    return Scaffold(
      body: ListTile(
        leading: Switch(value: isDark, onChanged: (isDark) => toggleAction),
      ),
    );
  }
}
