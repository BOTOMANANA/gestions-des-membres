// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class ShowConfirmDeleteDialog extends StatelessWidget {
  final String title;
  final String details;
  const ShowConfirmDeleteDialog({
    super.key,
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _dialogTitle(title: title, size: 14.0, weight: FontWeight.w600),
      content: _dialogBody(body: details),
      actions: [
        _customTextButton(
          onPressed: () => Navigator.pop(context, false),
          title: 'Annuler',
          backgroundColor: LightThemeColors.colorPrimary.withOpacity(0.12),
          textColor: LightThemeColors.colorPrimary,
        ),

        _customTextButton(
          onPressed: () => Navigator.pop(context, true),
          title: 'Supprimer',
          backgroundColor: LightThemeColors.colorPrimary,
          textColor: Colors.white,
        ),

        // ElevatedButton(
        //   onPressed: () => Navigator.pop(context, true),
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.blue,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(12.0),
        //     ),
        //   ),
        //   child: const Text('Supprimer'),
        // ),
      ],
    );
  }
}

TextButton _customTextButton({
  required VoidCallback onPressed,
  required String title,
  required Color backgroundColor,
  required Color textColor,
}) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    child: Text(
      title,
      style: AppFonts.robotoCondensedFont(size: 12.0, color: textColor),
    ),
  );
}

Text _dialogTitle({
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

Column _dialogBody({required String body}) {
  return Column(
    children: [
      _dialogTitle(title: 'Voulez-vous vraiment supprimer', size: 12.0),
      _dialogTitle(title: body, size: 12.0),
    ],
  );
}
