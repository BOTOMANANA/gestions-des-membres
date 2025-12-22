import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomFloatingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: LightThemeColors.colorPrimary,
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}

Widget customFloatingButtonWithText({
  required VoidCallback onPressed,
  required String icon,
  required String title,
  required double width,
}) {
  return SizedBox(
    width: width,
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
