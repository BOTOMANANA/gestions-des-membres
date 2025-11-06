// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';

class ShowConfirmDeleteDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String details,
  }) {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _dialogTitle(title: title, size: 16, weight: FontWeight.w600),
                  const SizedBox(height: 16),
                  _dialogBody(body: details),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _customTextButton(
                        onPressed: () => Navigator.pop(context, false),
                        title: 'Annuler',
                        backgroundColor: LightThemeColors.colorPrimary
                            .withOpacity(0.12),
                        textColor: LightThemeColors.colorPrimary,
                      ),
                      _customTextButton(
                        onPressed: () => Navigator.pop(context, true),
                        title: 'Supprimer',
                        backgroundColor: LightThemeColors.colorPrimary,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation1),
          child: child,
        );
      },
    );
  }

  static TextButton _customTextButton({
    required VoidCallback onPressed,
    required String title,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(
        title,
        style: AppFonts.robotoCondensedFont(size: 12.0, color: textColor),
      ),
    );
  }

  static Text _dialogTitle({
    required String title,
    required double size,
    FontWeight? weight,
  }) {
    return Text(
      title,
      style: AppFonts.robotoFont(
        size: size,
        color: LightThemeColors.textBlack,
        weight: weight,
      ),
    );
  }

  static Column _dialogBody({required String body}) {
    return Column(
      children: [
        _dialogTitle(title: 'Voulez-vous vraiment supprimer', size: 12.0),
        const SizedBox(height: 8),
        _dialogTitle(title: body, size: 12.0),
      ],
    );
  }
}
