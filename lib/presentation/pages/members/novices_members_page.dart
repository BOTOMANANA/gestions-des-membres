import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/button/custom_floating_button.dart';
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
      appBar: widgetAppBar(title: 'Novices', background: Colors.white),
      backgroundColor: Colors.white,
      body: Consumer<MemberProviders>(
        builder: (context, provider, _) {
          if (provider.state == MemberState.initial) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.getMembersByStatus(category: 'Novice');
            });
          }

          if (provider.state == MemberState.loading) {
            return widetCircularToLoadMembers();
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
                    itemCount: membersNovices.length,
                    itemBuilder: (context, index) {
                      return MemberItemWidget(
                        memberEntity: membersNovices[index],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center();
        },
      ),
      floatingActionButton: customFloatingButton(onPressed: () {}),
    );
  }
}
