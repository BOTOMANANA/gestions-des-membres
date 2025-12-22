import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputBorder enabledInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: LightThemeColors.textFieldBorderColors),
    );
  }

  static InputBorder focusedInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: LightThemeColors.colorPrimary),
    );
  }

  static Padding circularSearchingActive() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: 14.0,
        height: 14.0,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: LightThemeColors.colorPrimary,
        ),
      ),
    );
  }

  static cleanSearchButton({
    required BuildContext context,
    required bool hasText,
    required TextEditingController controller,
    required MemberProviders provider,
    required String category,
  }) {
    return IconButton(
      onPressed: () {
        // Si du texte est présent, on efface et on vide les résultats
        if (hasText) {
          controller.clear();
          provider.clearSearchResult();
          provider.getMembersByStatus(category: category);
        }
        FocusScope.of(context).unfocus();
      },
      icon: Image.asset(
        hasText ? 'assets/icons/close.png' : 'assets/icons/search.png',
        width: 18.0,
        height: 18.0,
      ),
    );
  }
}
