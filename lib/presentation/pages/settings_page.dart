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
    final appTheme = context.watch<ThemeNotifier>();
    final isDarkMode = appTheme.isDarkMode;

    final toggleAction = context.read<ThemeNotifier>().toggleTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Params'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Switch(
            value: isDarkMode,
            onChanged: (isDark) => toggleAction,
          ),
        ),
      ),
    );
  }
}
