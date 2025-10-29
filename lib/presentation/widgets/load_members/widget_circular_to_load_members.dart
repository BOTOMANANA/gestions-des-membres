// ignore_for_file: library_prefixes

import 'package:bottom_bar_matu/components/colors.dart' as LightThemeColors;
import 'package:flutter/material.dart';

Widget widetCircularToLoadMembers() {
  return Center(
    child: CircularProgressIndicator(color: LightThemeColors.colorPrimary),
  );
}
