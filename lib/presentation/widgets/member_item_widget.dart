// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/pages/members/members_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:association_appli/domain/entities/member_entity.dart';

class MemberItemWidget extends StatelessWidget {
  final MemberEntity memberEntity;
  const MemberItemWidget({super.key, required this.memberEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MembersProfilePage(id: memberEntity.id!),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              width: 1.0,
              color: LightThemeColors.colorPrimary.withOpacity(0.50),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/images/profilegirl.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        memberEntity.fullName,
                        style: AppFonts.robotoFont(
                          size: 14.0,
                          color: LightThemeColors.textBlack,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        memberEntity.country,
                        style: AppFonts.robotoCondensedFont(
                          size: 12.0,
                          color: LightThemeColors.textSemiBlack,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    "20/01/2026",
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
