// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/pages/members/members_profile_page.dart';
import 'package:association_appli/presentation/widgets/alert_dialog/show_confirm_delete_dialog.dart';
import 'package:association_appli/presentation/widgets/bottom_sheet/update_member_bottom_sheet.dart';
import 'package:association_appli/presentation/widgets/create_date_time_at.dart';
import 'package:association_appli/presentation/widgets/load_members/get_image_profile_of_member_in_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:provider/provider.dart';

class MemberItemWidget extends StatelessWidget {
  final MemberEntity memberEntity;
  const MemberItemWidget({super.key, required this.memberEntity});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<MemberProviders>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Slidable(
        key: ValueKey(memberEntity.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.3, // largeur totale du panneau (ajuste à ton goût)
          children: [
            SizedBox(width: 2.0),

            _customSlidable(
              onPressed: (context) async {
                final confirm = await ShowConfirmDeleteDialog.show(
                  context: context,
                  title: 'Suppression de membre',
                  details: memberEntity.fullName,
                );

                if (confirm == true) {
                  provider.deleteMember(id: memberEntity.id!);
                  provider.getMembersByStatus(category: memberEntity.category!);
                }
              },
              backgroundColor: LightThemeColors.textFieldBorderColors,
              iconPath: 'assets/icons/delete.png',
            ),

            const SizedBox(width: 2.0),
            _customSlidable(
              onPressed:
                  (context) => _showUpdateMemberBottomSheet(context: context),
              backgroundColor: LightThemeColors.colorPrimary,
              iconPath: 'assets/icons/update.png',
            ),
          ],
        ),

        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              width: 1.0,
              color: LightThemeColors.textFieldBorderColors,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14.0),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => FocusScope.of(context).unfocus(),
              );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MembersProfilePage(id: memberEntity.id!),
                ),
              );
            },
            child: _displayFullNameAndCountryOfMember(),
          ),
        ),
      ),
    );
  }

  CustomSlidableAction _customSlidable({
    required SlidableActionCallback? onPressed,
    required Color backgroundColor,
    required String iconPath,
  }) {
    return CustomSlidableAction(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      borderRadius: BorderRadius.circular(12.0),
      child: Image.asset(iconPath),
    );
  }

  Widget _displayFullNameAndCountryOfMember() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          getImageProfileMemberInStorageFile(
            member: memberEntity,
            size: 50.0,
            folderPath: '/storage/emulated/0/Picture',
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getMemberFullName(data: memberEntity.fullName),
                const SizedBox(height: 2),
                _getMemberCountry(data: memberEntity.country),
              ],
            ),
          ),
          createDateTimeAt(
            createAt: memberEntity.createAt!,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  Text _getMemberFullName({required String data}) {
    return Text(
      data,
      style: AppFonts.robotoFont(
        size: 13.0,
        color: LightThemeColors.textBlack,
        weight: FontWeight.w600,
      ),
    );
  }

  Text _getMemberCountry({required String data}) {
    return Text(
      data,
      style: AppFonts.robotoCondensedFont(
        size: 11.0,
        color: LightThemeColors.textSemiBlack,
      ),
    );
  }

  Future _showUpdateMemberBottomSheet({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UpdateMemberBottomSheet(memberEntity: memberEntity),
    );
  }
}
