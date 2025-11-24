import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class BuildLabelWidget extends StatelessWidget {
  final String label;
  const BuildLabelWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: AppFonts.robotoCondensedFont(
          size: 12.0,
          color: LightThemeColors.textFieldBorderColors,
        ),
      ),
    );
  }
}
