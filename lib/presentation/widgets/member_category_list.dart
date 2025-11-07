// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/routes/page_routes.dart';
import 'package:flutter/material.dart';

List hierarchyTitles = ['Novice', 'Anciens', 'Doyens', 'Voir tout'];
List iconPaths = [
  'assets/icons/call.png',
  'assets/icons/call.png',
  'assets/icons/call.png',
  'assets/icons/call.png',
];
List pageRoutes = [
  PageRoutes.novice,
  PageRoutes.senior,
  PageRoutes.createMember,
  PageRoutes.createMember,
];

Widget buildHierarchyList({required BuildContext context}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(hierarchyTitles.length, (index) {
        return Column(
          children: [
            buildHierarchyCard(
              context: context,
              icon: iconPaths[index],
              route: pageRoutes[index],
            ),
          ],
        );
      }),
    ),
  );
}

Widget buildHierarchyCard({
  required BuildContext context,
  required String icon,
  required String route,
}) {
  return InkWell(
    onTap: () => Navigator.pushNamed(context, route),
    child: Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: LightThemeColors.colorPrimary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Image.asset(icon),
    ),
  );
}
