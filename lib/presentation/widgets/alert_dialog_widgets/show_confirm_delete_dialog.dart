// ignore_for_file: deprecated_member_use
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/snack_bar_widget.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_button_cancel.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
                borderRadius: BorderRadius.circular(32),
              ),
              child: _contentDialog(
                context: context,
                title: title,
                details: details,
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
    required String title,
    required String details,
  }) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: customButtonCancel(context: context),
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _bodyOfAlertDialog(body: details),
            const Spacer(),
            _customTextButton(
              onPressed: () {
                Navigator.pop(context, true);
                snackBarWidget(
                  context: context,
                  title: title,
                  details: details,
                  type: ContentType.success,
                );
              },
              title: 'Supprimer',
              backgroundColor: LightThemeColors.colorPrimary,
              textColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  static Widget _customTextButton({
    required VoidCallback onPressed,
    required String title,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return SizedBox(
      width: 220.0,
      height: 48.0,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Text(
          title,
          style: AppFonts.robotoCondensedFont(size: 14.0, color: textColor),
        ),
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
        color: LightThemeColors.textSemiBlack,
        weight: weight,
      ),
    );
  }

  static Column _bodyOfAlertDialog({required String body}) {
    return Column(
      children: [
        const SizedBox(height: 28.0),
        Image.asset('assets/images/garbage.png', width: 110.0, height: 110.0),
        const SizedBox(height: 8.0),
        _dialogTitle(
          title: 'Voulez-vous vraiment supprimer',
          size: 16.0,
          weight: FontWeight.w500,
        ),
        const SizedBox(height: 8),
        _dialogTitle(title: body, size: 14.0, weight: FontWeight.w500),
      ],
    );
  }
}
