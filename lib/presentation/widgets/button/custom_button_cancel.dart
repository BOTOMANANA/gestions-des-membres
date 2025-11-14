// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:flutter/material.dart';

Widget customButtonCancel({required BuildContext context}) {
  final Offset distance = Offset(4, 4);
  final double blur = 15;
  final color = LightThemeColors.textBlack.withOpacity(0.12);
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(color: color, offset: distance, blurRadius: blur),
          BoxShadow(color: color, offset: -distance, blurRadius: blur),
        ],
      ),
      child: Icon(Icons.close),
    ),
  );
}
