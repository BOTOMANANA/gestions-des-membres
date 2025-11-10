// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/routes/page_routes.dart';
import 'package:flutter/material.dart';

List categoriesTitles = ['Novice', 'Anciens', 'Doyens', 'Voir tout'];
List iconPaths = [
  'assets/icons/novices.png',
  'assets/icons/people.png',
  'assets/icons/old-people.png',
  'assets/icons/seeall.png',
];
List _pageRoutes = [
  PageRoutes.novice,
  PageRoutes.senior,
  PageRoutes.older,
  PageRoutes.createMember,
];

Widget createCategoryNavigationRow({required BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(categoriesTitles.length, (index) {
      return Column(
        children: [
          _createCategoryCard(
            context: context,
            icon: iconPaths[index],
            route: _pageRoutes[index],
          ),
          _createCategoryLabel(title: categoriesTitles[index]),
        ],
      );
    }),
  );
}

Widget _createCategoryCard({
  required BuildContext context,
  required String icon,
  required String route,
}) {
  return InkWell(
    onTap: () => Navigator.pushNamed(context, route),
    child: Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: LightThemeColors.colorPrimary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(60.0),
      ),
      child: Image.asset(icon),
    ),
  );
}

Widget _createCategoryLabel({required String title}) {
  return Text(
    title,
    style: AppFonts.robotoFont(
      size: 14.0,
      color: LightThemeColors.textBlack,
      weight: FontWeight.w600,
    ),
  );
}
