import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/alert_dialog/show_confirm_delete_dialog.dart';
import 'package:association_appli/presentation/widgets/button/custom_floating_button.dart';
import 'package:association_appli/presentation/widgets/button/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/input_search_members.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_circular_to_load_members.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_error_to_load_members.dart';
import 'package:association_appli/presentation/widgets/member_item_widget.dart';
import 'package:association_appli/presentation/widgets/widget_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NovicesMembersPage extends StatelessWidget {
  const NovicesMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgetAppBar(
        context: context,
        icon: 'assets/icons/arrowleftt.png',
        title: 'Novices',
        background: Colors.white,
        actions: [
          customIconButton(
            iconPath: 'assets/icons/filepdf.png',
            size: 16.0,
            onPressed: () {},
          ),
          SizedBox(width: 8.0),
        ],
      ),
      backgroundColor: Colors.white,
      body: Consumer<MemberProviders>(
        builder: (context, provider, _) {
          if (provider.state == MemberState.initial) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.getMembersByStatus(category: 'Novice');
            });
          }

          if (provider.state == MemberState.loading) {
            return widgetCircularToLoadMembers();
          }

          if (provider.state == MemberState.error) {
            return widgetErrorToLoadMembers(provider: provider);
          }

          final membersNovices =
              provider.membreSearch.isNotEmpty
                  ? provider.membreSearch
                  : provider.members;

          if (membersNovices.isEmpty) {
            return const Center(child: Text('aucun novice a trouver'));
          }
          if (provider.state == MemberState.succes) {
            return _getAndDisplayNovices(novices: membersNovices);
          }
          return const Center();
        },
      ),
      floatingActionButton: customFloatingButton(
        onPressed: () {
          ShowConfirmDeleteDialog.show(
            context: context,
            title: 'title',
            details: 'details',
          );
        },
      ),
    );
  }

  Widget _getAndDisplayNovices({required List<MemberEntity> novices}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: InputSearchMembers(),
        ),
        SizedBox(height: 12.0),
        Expanded(
          child: ListView.builder(
            itemCount: novices.length,
            itemBuilder: (context, index) {
              return MemberItemWidget(memberEntity: novices[index]);
            },
          ),
        ),
      ],
    );
  }
}
