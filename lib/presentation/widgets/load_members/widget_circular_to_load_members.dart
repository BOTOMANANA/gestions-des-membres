// ignore_for_file: library_prefixes

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:flutter/material.dart';

Widget widgetCircularToLoadMembers() {
  return Center(
    child: CircularProgressIndicator(color: LightThemeColors.colorPrimary),
  );
}
