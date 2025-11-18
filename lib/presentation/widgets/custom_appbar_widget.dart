import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

AppBar customAppBarWidget({
  required BuildContext context,
  String? icon,
  required String title,
  required Color background,
  List<Widget>? actions,
}) {
  return AppBar(
    leading: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Image.asset(icon!),
    ),
    title: Text(
      title,
      style: AppFonts.robotoCondensedFont(
        size: 20.0,
        color: LightThemeColors.textBlack,
      ),
    ),
    centerTitle: true,
    backgroundColor: background,
    actions: actions,
  );
}
