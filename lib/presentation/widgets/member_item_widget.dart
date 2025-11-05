// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/pages/members/members_profile_page.dart';
import 'package:association_appli/presentation/widgets/load_members/image_member_profile.dart';
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
          extentRatio: 0.45, // largeur totale du panneau (ajuste à ton goût)
          children: [
            SizedBox(width: 2.0),
            // 🗑️ Bouton supprimer
            SlidableAction(
              onPressed: (context) async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Supprimer ce membre ?'),
                        content: Text(
                          'Voulez-vous vraiment supprimer ${memberEntity.fullName} ?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Annuler'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: const Text('Supprimer'),
                          ),
                        ],
                      ),
                );

                if (confirm == true) {
                  provider.deleteMember(id: memberEntity.id!);
                  provider.getMembersByStatus(category: memberEntity.category!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '✅ ${memberEntity.fullName} a été supprimé avec succès',
                      ),
                    ),
                  );
                }
              },
              backgroundColor: LightThemeColors.textFieldBorderColors,
              foregroundColor: Colors.white,
              icon: Icons.delete_outlined,
              borderRadius: BorderRadius.circular(12.0),
              spacing: 4.0, // petit espace interne entre icône et texte
            ),
            const SizedBox(width: 2.0),
            // ✏️ Bouton modifier
            SlidableAction(
              onPressed: (context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MembersProfilePage(id: memberEntity.id!),
                  ),
                );
              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Modifier',
              borderRadius: BorderRadius.circular(12.0),
              spacing: 4.0,
            ),
          ],
        ),

        // ✅ Le contenu principal de ton item
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MembersProfilePage(id: memberEntity.id!),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  imageMemberProfileRounded(member: memberEntity, size: 50.0),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          memberEntity.fullName,
                          style: AppFonts.robotoFont(
                            size: 13.0,
                            color: LightThemeColors.textBlack,
                            weight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          memberEntity.country,
                          style: AppFonts.robotoCondensedFont(
                            size: 11.0,
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
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
