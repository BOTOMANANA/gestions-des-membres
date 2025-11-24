// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';

class BuildErrorStatePlaceholder extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  const BuildErrorStatePlaceholder({
    super.key,
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptyStateWidget(
            title: 'Erreur',
            imageEmpty: 'assets/images/errorfolder.png',
            message: message,
          ),
          SizedBox(height: 4.0),
          CustomIconButton(
            icon: 'assets/icons/update.png',
            backgroundColor: LightThemeColors.colorPrimary.withOpacity(0.16),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
