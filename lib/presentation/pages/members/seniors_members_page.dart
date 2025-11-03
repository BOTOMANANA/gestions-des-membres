import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/input_search_members.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_circular_to_load_members.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_error_to_load_members.dart';
import 'package:association_appli/presentation/widgets/member_item_widget.dart';
import 'package:association_appli/presentation/widgets/widget_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeniorsMembersPage extends StatelessWidget {
  const SeniorsMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgetAppBar(title: 'title'),
      body: Consumer<MemberProviders>(
        builder: (context, provider, child) {
          if (provider.state == MemberState.loading) {
            return widetCircularToLoadMembers();
          }

          if (provider.state == MemberState.error) {
            return widgetErrorToLoadMembers(provider: provider);
          }

          final memberToShow =
              provider.membreSearch.isNotEmpty
                  ? provider.membreSearch
                  : provider.members;

          if (memberToShow.isEmpty) {
            return Column(
              children: [
                const InputSearchMembers(),
                Center(child: Text('Aucun membres trouver')),
              ],
            );
          }

          if (provider.state == MemberState.succes) {
            return _listAllSeniorMembers(members: memberToShow);
          }
          return Center(child: Text('aucun condition est vrai'));
        },
      ),
    );
  }

  Widget _listAllSeniorMembers({required List members}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InputSearchMembers(),
        SizedBox(height: 12.0),
        Expanded(
          child: ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              return MemberItemWidget(memberEntity: members[index]);
            },
          ),
        ),
      ],
    );
  }
}
