// ignore_for_file: deprecated_member_use

import 'dart:math' as Math;
import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/routes/page_routes.dart';
import 'package:association_appli/presentation/widgets/button/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/caroussel_widget.dart';
import 'package:association_appli/presentation/widgets/create_category_navigation_row.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_circular_to_load_members.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_error_to_load_members.dart';
import 'package:association_appli/presentation/widgets/member_office_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MemberProviders>(
        context,
        listen: false,
      ).loadResponsibleMembers();
    });
  }

  void _loadOfficeMembers() {
    Provider.of<MemberProviders>(
      context,
      listen: false,
    ).loadResponsibleMembers();
  }

  // 2. Fonction pour la navigation avec attente de retour
  void _navigateAndRefresh(BuildContext context) async {
    await Navigator.pushNamed(context, PageRoutes.createMember);
    _loadOfficeMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeaderWidget(),
      backgroundColor: Colors.white,
      body: Consumer<MemberProviders>(
        builder: (context, provider, _) {
          final responsibleMembers = provider.responsibleMembersList;
          return Column(
            children: [
              // CarousselWidget(),
              CarouselImageWidget(),
              _buildLabelCategory(
                context: context,
                onPressedAdd: _navigateAndRefresh,
              ),
              createCategoryNavigationRow(context: context),
              SizedBox(height: 4.0),

              _buildLabelOfficeList(context: context),
              if (provider.state == MemberState.loading &&
                  responsibleMembers.isEmpty)
                Expanded(child: Center(child: widgetCircularToLoadMembers()))
              else if (provider.state == MemberState.error &&
                  responsibleMembers.isEmpty)
                Expanded(
                  child: Center(
                    child: widgetErrorToLoadMembers(provider: provider),
                  ),
                )
              else if (responsibleMembers.isEmpty)
                const Center(child: Text('Aucun membre responsable récupéré.'))
              else
                Expanded(
                  child: _getAndDisplayResponsibleMembers(
                    responsibleList: responsibleMembers,
                  ),
                ),
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
        size: 18.0,
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
              'Votre association',
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

Widget _buildLabelCategory({
  required BuildContext context,
  required Function(BuildContext) onPressedAdd,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _customTextTitle(title: 'Categories'),
        IconButton(
          onPressed: () => onPressedAdd(context),
          icon: Icon(Icons.add, color: LightThemeColors.colorPrimary),
        ),
      ],
    ),
  );
}

Widget _buildLabelOfficeList({required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _customTextTitle(title: 'Listes burreaux'),
        TextButton(
          onPressed:
              () => Navigator.pushNamed(context, PageRoutes.officeMembers),
          child: Text(
            'Voir plus',
            style: AppFonts.robotoCondensedFont(
              size: 14.0,
              color: LightThemeColors.textSemiBlack.withOpacity(0.5),
              weight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _customTextTitle({required String title}) {
  return Text(
    title,
    style: AppFonts.robotoFont(
      size: 16.0,
      color: LightThemeColors.textBlack,
      weight: FontWeight.w600,
    ),
  );
}

Widget _getAndDisplayResponsibleMembers({
  required List<MemberEntity> responsibleList,
}) {
  const int maxItemsToShow = 4;
  final int itemCount = Math.min(responsibleList.length, maxItemsToShow);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return MemberOfficeItemWidget(
                memberEntity: responsibleList[index],
              );
            },
          ),
        ),
      ),
    ],
  );
}
