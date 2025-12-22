// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/pages/activity_page/activity_page.dart';
import 'package:association_appli/presentation/pages/home_page.dart';
import 'package:association_appli/presentation/pages/profile_page.dart';
import 'package:association_appli/presentation/pages/settings_page.dart';
import 'package:association_appli/presentation/pages/statistics_page.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:bottom_bar_matu/bottom_bar_label_slide/bottom_bar_label_slide.dart';
import 'package:flutter/material.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  final PageController controller = PageController();
  int _currentIndex = 0;
  // bool isSelected = true;

  final List<Widget> _pages = [
    HomePage(),
    ActivityPage(),
    StatisticsPage(),
    SettingsPage(),
    ProfilePage(),
  ];

  final List labels = ['Accueil', 'Activités', 'Statis', 'Params', 'Profile'];
  final List iconsInactiveList = [
    'assets/icons/home.png',
    'assets/icons/task.png',
    'assets/icons/stats.png',
    'assets/icons/params.png',
    'assets/icons/profile.png',
  ];

  final List iconsActiveList = [
    'assets/icons/focushome.png',
    'assets/icons/focustask.png',
    'assets/icons/focusstats.png',
    'assets/icons/focusparams.png',
    'assets/icons/focusprofile.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 64.0,
        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, -2),
              blurRadius: 24.0,
              spreadRadius: 1,
            ),
          ],
        ),

        child: BottomBarLabelSlide(
          selectedIndex: _currentIndex,
          color: LightThemeColors.colorPrimary,
          backgroundColor: Colors.white,

          items: List.generate(iconsInactiveList.length, (index) {
            return _buildBottomNavBarItem(
              label: labels[index],
              icon: iconsInactiveList[index],
              focusIcon: iconsActiveList[index],
              isSelected: _currentIndex == index,
            );
          }),
          onSelect: (index) {
            setState(() => _currentIndex = index);
          },
        ),
      ),
    );
  }

  BottomBarItem _buildBottomNavBarItem({
    required String label,
    required String icon,
    required String focusIcon,
    required bool isSelected,
  }) {
    return BottomBarItem(
      iconBuilder: (color) => Image.asset(isSelected ? focusIcon : icon),
      label: label,
      iconSize: 24.0,
      labelTextStyle: _onLabelStyle(isSelected: isSelected),
    );
  }
}

TextStyle _onLabelStyle({required bool isSelected}) {
  final color = LightThemeColors.textFieldBorderColors;
  final focusColor = LightThemeColors.colorPrimary;
  return AppFonts.robotoCondensedFont(
    size: isSelected ? 14.0 : 12.0,
    color: isSelected ? focusColor : color,
    weight: isSelected ? FontWeight.bold : FontWeight.w500,
  );
}
