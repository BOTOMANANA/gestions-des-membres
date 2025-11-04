import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/pages/members/members_profile_page.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Slidable(
        key: ValueKey(memberEntity.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.45, // largeur totale du panneau (ajuste à ton goût)
          children: [
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
                                borderRadius: BorderRadius.circular(12),
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
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Supprimer',
              borderRadius: BorderRadius.circular(14),
              spacing: 4, // petit espace interne entre icône et texte
            ),
            const SizedBox(width: 6), // 🌟 espace entre les 2 actions
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
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Modifier',
              borderRadius: BorderRadius.circular(14),
              spacing: 4,
            ),
          ],
        ),

        // ✅ Le contenu principal de ton item
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              width: 1.0,
              color: LightThemeColors.colorPrimary.withOpacity(0.50),
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
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
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
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
