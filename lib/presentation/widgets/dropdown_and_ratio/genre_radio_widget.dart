import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/widgets.dart';

Widget genreChoiceText({required String option, required bool canSelected}) {
  return Text(
    option,
    style: AppFonts.robotoCondensedFont(
      size: canSelected ? 16.0 : 14.0,
      color:
          canSelected
              ? LightThemeColors.colorWhite
              : LightThemeColors.textBlack,
      weight: canSelected ? FontWeight.bold : FontWeight.w500,
    ),
  );
}
