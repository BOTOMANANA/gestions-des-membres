// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/button/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/caroussel_widget.dart';
import 'package:association_appli/presentation/widgets/member_category_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeaderWidget(),
      backgroundColor: Colors.white,
      body: Consumer<MemberProviders>(
        builder: (context, provider, _) {
          return Column(
            children: [
              CarousselWidget(),
              _buildLabelCategory(),
              buildHierarchyList(context: context),
              _buildLabelOfficeList(),
            ],
          );
        },
      ),
    );
  }

  AppBar _buildHeaderWidget() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: customIconButton(
        iconPath: 'assets/icons/menu.png',
        size: 24.0,
        onPressed: () {},
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/localisation.png'),
            SizedBox(width: 4.0),
            Text(
              'Association name',
              style: AppFonts.robotoCondensedFont(
                size: 18.0,
                color: LightThemeColors.textBlack,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: LightThemeColors.colorPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildLabelCategory() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Categories'),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add, color: LightThemeColors.colorPrimary),
        ),
      ],
    ),
  );
}

Widget _buildLabelOfficeList() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Listes burreaux'),
        TextButton(onPressed: () {}, child: Text('Voir plus')),
      ],
    ),
  );
}
