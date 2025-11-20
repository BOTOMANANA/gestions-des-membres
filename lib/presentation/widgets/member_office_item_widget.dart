// ignore_for_file: deprecated_member_use

import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_member_profile_image.dart';
import 'package:flutter/material.dart';

class MemberOfficeItemWidget extends StatelessWidget {
  final MemberEntity memberEntity;
  const MemberOfficeItemWidget({super.key, required this.memberEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Container(
        width: 132.0,
        height: 400.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: BoxBorder.all(
            color: LightThemeColors.textFieldBorderColors.withOpacity(0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: LightThemeColors.textBlack.withOpacity(0.05),
              offset: Offset(0, 2),
              blurRadius: 12.0,
            ),
            BoxShadow(
              color: LightThemeColors.colorPrimary.withOpacity(0.05),
              offset: Offset(-2, 0),
              blurRadius: 24.0,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 6.0),
            buildMemberProfileImage(
              member: memberEntity,
              size: 80.0,
              folderPath: '/storage/emulated/0/Picture',
            ),
            _buildMemberFullNameText(data: memberEntity.fullName),
            buildMemberResponsibleText(
              data: memberEntity.memberResponsability ?? 'Non defini',
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMemberFullNameText({required String data}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Text(
      data,
      style: AppFonts.robotoFont(
        size: 13.0,
        color: LightThemeColors.textBlack,
        weight: FontWeight.w500,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Text buildMemberResponsibleText({required String data}) {
  return Text(
    data,
    style: AppFonts.robotoCondensedFont(
      size: 12.0,
      color: LightThemeColors.textSemiBlack,
    ),
  );
}
