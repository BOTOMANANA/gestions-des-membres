import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

Widget customFloatingButton({required VoidCallback onPressed}) {
  return FloatingActionButton(
    onPressed: onPressed,
    backgroundColor: LightThemeColors.colorPrimary,
    child: Icon(Icons.add, color: Colors.white),
  );
}

Widget customFloatingButtonWithText({
  required VoidCallback onPressed,
  required String icon,
  required String title,
  required double buttonSize,
}) {
  return SizedBox(
    width: buttonSize,
    child: FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: LightThemeColors.colorPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon),
          SizedBox(width: 4.0),
          Text(
            title,
            style: AppFonts.robotoFont(size: 16.0, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
