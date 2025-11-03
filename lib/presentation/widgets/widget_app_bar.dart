import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

AppBar widgetAppBar({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: AppFonts.robotoCondensedFont(size: 14.0, color: Colors.black),
    ),
    centerTitle: true,
  );
}
