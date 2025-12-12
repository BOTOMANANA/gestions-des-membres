// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:flutter/material.dart';

class DisplayMemberProductActivity extends StatelessWidget {
  const DisplayMemberProductActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      child: Container(
        width: 380.0,
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: LightThemeColors.colorPrimary.withOpacity(0.16),
            width: 1,
          ),
        ),
      ),
    );
  }
}
