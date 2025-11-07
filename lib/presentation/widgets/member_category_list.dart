import 'package:association_appli/presentation/routes/page_routes.dart';
import 'package:flutter/material.dart';

List title = ['Novice', 'Anciens', 'Doyens', 'Voir tout'];
List iconPath = ['assets/icons/call.png', 'assets/icons/call.png'];
List routePage = [
  PageRoutes.novice,
  PageRoutes.senior,
  PageRoutes.createMember,
];

Row _hierarchyList({required BuildContext context}) {
  return Row(
    children: List.generate(title.length, (index) {
      return Column(
        children: [
          _roundedCard(
            context: context,
            icon: iconPath[index],
            route: routePage[index],
          ),
        ],
      );
    }),
  );
}

Widget _roundedCard({
  required BuildContext context,
  required String icon,
  required String route,
}) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, route),
    child: Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
      child: Image.asset(icon),
    ),
  );
}
