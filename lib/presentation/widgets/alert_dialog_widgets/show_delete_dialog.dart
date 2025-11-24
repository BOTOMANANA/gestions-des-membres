// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_button_cancel.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_text_buttom.dart';
import 'package:flutter/material.dart';

class ShowDeleteDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String details,
    required VoidCallback onPressed,
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
              width: 300.0,
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: _contentDialog(
                context: context,
                details: details,
                onPressed: onPressed,
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

  static Widget _contentDialog({
    required BuildContext context,
    required String details,
    required VoidCallback onPressed,
  }) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: customButtonCancel(context: context),
        ),

        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDialogContent(text: details),
              const Spacer(),
              CustomTextButtom(
                background: LightThemeColors.colorPrimary,
                title: 'Supprimer',
                color: Colors.white,
                width: 220.0,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Text _buildText({
    required String text,
    required double size,
    FontWeight? weight,
  }) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: AppFonts.robotoFont(
        size: size,
        color: LightThemeColors.textSemiBlack,
        weight: weight,
      ),
    );
  }

  static Column _buildDialogContent({required String text}) {
    return Column(
      children: [
        const SizedBox(height: 28.0),
        Image.asset('assets/images/garbage.png', width: 110.0, height: 110.0),
        const SizedBox(height: 8.0),
        _buildText(
          text: 'Voulez-vous vraiment supprimer',
          size: 14.0,
          weight: FontWeight.w500,
        ),
        const SizedBox(height: 2.0),
        _buildText(text: text, size: 14.0, weight: FontWeight.w500),
      ],
    );
  }
}
