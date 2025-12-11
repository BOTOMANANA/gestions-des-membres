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
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    leadingWidth: 60.0,
    leading: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Image.asset(icon!),
    ),

    elevation: 0.0,
    title: Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: AppFonts.robotoCondensedFont(
        size: 18.0,
        color: LightThemeColors.textBlack,
      ),
    ),
    centerTitle: true,
    backgroundColor: background,
    actions: actions,
  );
}
