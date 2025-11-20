// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_button_cancel.dart';
import 'package:flutter/material.dart';

class ShowResponsibleDialog {
  static final List<Map<String, String>> responsabilityOptions = [
    {'id': '5', 'icon': 'assets/icons/president.png', 'name': 'President'},
    {'id': '5', 'icon': 'assets/icons/oldman.png', 'name': 'President-doyen'},
    {'id': '5', 'icon': 'assets/icons/secretary.png', 'name': 'Secrétaire'},
    {'id': '5', 'icon': 'assets/icons/secretary.png', 'name': 'Trésorier'},
    {'id': '1', 'icon': 'assets/icons/basketball.png', 'name': 'Basket-ball'},
    {'id': '2', 'icon': 'assets/icons/football.png', 'name': 'Foot-ball'},
    {'id': '3', 'icon': 'assets/icons/quiz.png', 'name': 'Quiz'},
    {'id': '4', 'icon': 'assets/icons/materials.png', 'name': 'Matériels'},
    {'id': '5', 'icon': 'assets/icons/danse.png', 'name': 'Danse'},
    {'id': '5', 'icon': 'assets/icons/audit.png', 'name': 'Commissaire-compte'},
  ];

  static Future<String?> showDialog({required BuildContext context}) {
    return showGeneralDialog<String>(
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
            child: _buildBodyContent(context),
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

  static Widget _buildBodyContent(BuildContext context) {
    return Container(
      height: 330.0,
      width: 300.0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: customButtonCancelWithSize(context: context, size: 30.0),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              _title(),
              Expanded(child: _buildListResponsible(context)),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildListResponsible(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ListView.builder(
        itemCount: responsabilityOptions.length,
        itemBuilder: (context, index) {
          final option = responsabilityOptions[index];
          final name = option['name']!;
          final icon = option['icon']!;

          return _responsibleItem(context: context, icon: icon, name: name);
        },
      ),
    );
  }

  static Widget _title() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0),
      child: Text(
        'Choisir une responsabilité',
        style: AppFonts.robotoCondensedFont(
          size: 18,
          color: LightThemeColors.textBlack,
          weight: FontWeight.w600,
        ),
      ),
    );
  }

  static Widget _responsibleItem({
    required BuildContext context,
    required String icon,
    required String name,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, name);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Image.asset(icon, width: 24, height: 24),
            const SizedBox(width: 16.0),
            Text(
              name,
              style: AppFonts.robotoCondensedFont(
                size: 18,
                color: LightThemeColors.textSemiBlack,
                weight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
