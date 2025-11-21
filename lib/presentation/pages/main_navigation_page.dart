// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/pages/activity_page/activity_page.dart';
import 'package:association_appli/presentation/pages/home_page.dart';
import 'package:association_appli/presentation/widgets/empty_activity_in_page.dart';
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
  bool isSelected = true;

  final List<Widget> _pages = [
    HomePage(),
    ActivityPage(),
    // EmptyActivityInPage(
    //   imageEmpty: 'assets/images/document.png',
    //   title: 'Pas d acitivite',
    //   description:
    //       'Commencez votre premier activite depuis maintainent! Creez-en une et passez a laction',
    // ),
    EmptyActivityInPage(
      imageEmpty: 'assets/images/statistics.png',
      title: 'Pas d acitivite',
      description:
          'Commencez votre premier activite depuis maintainent! Creez-en une et passez a laction',
    ),

    Center(child: Text('settings of my application AntMobile')),
    Center(child: Text('Profile of your association here')),
  ];

  final List labels = ['Accueil', 'Activites', 'Statis', 'Params', 'Profile'];
  final List iconsPaths = [
    'assets/icons/home.png',
    'assets/icons/task.png',
    'assets/icons/stats.png',
    'assets/icons/params.png',
    'assets/icons/profile.png',
  ];

  final List iconsFocusPaths = [
    'assets/icons/focushome.png',
    'assets/icons/focustask.png',
    'assets/icons/focusstats.png',
    'assets/icons/focusparams.png',
    'assets/icons/focusprofile.png',
  ];

  @override
  void dispose() {
    super.dispose();
  }

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

          items: List.generate(iconsPaths.length, (index) {
            return _buildBottomNavBarItem(
              label: labels[index],
              icon: iconsPaths[index],
              focusIcon: iconsFocusPaths[index],
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
      labelTextStyle: isSelected ? _onLabelFocused() : _onLabel(),
    );
  }
}

TextStyle _onLabelFocused() {
  return AppFonts.robotoCondensedFont(
    size: 14.0,
    color: LightThemeColors.colorPrimary,
    weight: FontWeight.bold,
  );
}

TextStyle _onLabel() {
  return AppFonts.robotoCondensedFont(
    size: 12.0,
    color: LightThemeColors.textFieldBorderColors,
    weight: FontWeight.w500,
  );
}
