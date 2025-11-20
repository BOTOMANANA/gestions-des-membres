// ignore_for_file: deprecated_member_use

import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/pages/date_range_exemple_page.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/member_office_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfficeMembersPage extends StatefulWidget {
  const OfficeMembersPage({super.key});

  @override
  State<OfficeMembersPage> createState() => _OfficeMembersPageState();
}

class _OfficeMembersPageState extends State<OfficeMembersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      Provider.of<MemberProviders>(
        context,
        listen: false,
      ).loadResponsibleMembers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DateRangeExamplePage()),
          );
        },
      ),
      appBar: _customAppBar(),
      body: Consumer<MemberProviders>(
        builder: (context, providers, _) {
          final officeMembers = providers.responsibleMembersList;
          return _buildOfficeMemberGrid(officeMembersList: officeMembers);
        },
      ),
    );
  }

  AppBar _customAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Image.asset('assets/icons/arrowleftt.png'),
      ),
      title: Text(
        'Membres des burreaux',
        style: AppFonts.robotoCondensedFont(
          size: 20.0,
          color: LightThemeColors.textBlack,
        ),
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12.0),
        side: BorderSide(
          color: LightThemeColors.textFieldBorderColors.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _buildOfficeMemberGrid({
    required List<MemberEntity> officeMembersList,
  }) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: officeMembersList.length,
      itemBuilder: (context, index) {
        return MemberOfficeItemWidget(memberEntity: officeMembersList[index]);
      },
    );
  }
}
