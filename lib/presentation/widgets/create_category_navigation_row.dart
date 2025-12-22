// ignore_for_file: deprecated_member_use
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/routes/page_routes.dart';
import 'package:flutter/material.dart';

class CreateCategoryNavigationRow extends StatelessWidget {
  const CreateCategoryNavigationRow({super.key});

  @override
  Widget build(BuildContext context) {
    List categoriesName = ['Novice', 'Anciens', 'Doyens', 'Voir tout'];
    List iconsList = [
      'assets/icons/novices.png',
      'assets/icons/people.png',
      'assets/icons/old-people.png',
      'assets/icons/seeall.png',
    ];
    List pageRoutes = [
      PageRoutes.novice,
      PageRoutes.senior,
      PageRoutes.older,
      PageRoutes.allMembers,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(categoriesName.length, (index) {
        return Column(
          children: [
            _createCategoryCard(
              context: context,
              icon: iconsList[index],
              pageRoute: pageRoutes[index],
            ),
            _createCategoryName(name: categoriesName[index]),
          ],
        );
      }),
    );
  }

  InkWell _createCategoryCard({
    required BuildContext context,
    required String icon,
    required String pageRoute,
  }) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, pageRoute),
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
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

  Text _createCategoryName({required String name}) {
    return Text(
      name,
      style: AppFonts.robotoFont(
        size: 14.0,
        color: LightThemeColors.textSemiBlack,
        weight: FontWeight.w600,
      ),
    );
  }
}
