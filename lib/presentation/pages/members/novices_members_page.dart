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

class NovicesMembersPage extends StatefulWidget {
  const NovicesMembersPage({super.key});

  @override
  State<NovicesMembersPage> createState() => _NovicesMembersPageState();
}

class _NovicesMembersPageState extends State<NovicesMembersPage> {
  @override
  void initState() {
    super.initState();

    // 💡 MODIFICATION: L'appel au provider est déplacé dans initState.
    // Cela garantit qu'il est appelé à chaque fois que la page est ouverte,
    // résolvant le problème d'état persistant et assurant le rafraîchissement.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // On utilise 'listen: false' car nous sommes dans initState
      Provider.of<MemberProviders>(
        context,
        listen: false,
      ).getMembersByStatus(category: 'Novice');
    });
  }

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
          // if (provider.state == MemberState.initial) {
          //   WidgetsBinding.instance.addPostFrameCallback((_) {
          //     provider.getMembersByStatus(category: 'Novice');
          //   });
          // }

          if (provider.state == MemberState.loading) {
            return widgetCircularToLoadMembers();
          }

          if (provider.state == MemberState.error) {
            return widgetErrorToLoadMembers(provider: provider);
          }

          final membersNovices =
              provider.searchedMembers.isNotEmpty
                  ? provider.searchedMembers
                  : provider.members;

          if (membersNovices.isEmpty) {
            return const Center(child: Text('aucun novice a trouver'));
          }
          if (provider.state == MemberState.succes) {
            return _getAndDisplayNoviceMembers(noviceList: membersNovices);
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

  Widget _getAndDisplayNoviceMembers({required List<MemberEntity> noviceList}) {
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
            itemCount: noviceList.length,
            itemBuilder: (context, index) {
              return MemberItemWidget(memberEntity: noviceList[index]);
            },
          ),
        ),
      ],
    );
  }
}
