import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/show_confirm_delete_dialog.dart';
import 'package:association_appli/presentation/widgets/button/custom_floating_button.dart';
import 'package:association_appli/presentation/widgets/button/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/custom_appbar_widget.dart';
import 'package:association_appli/presentation/widgets/input_search_members.dart';
import 'package:association_appli/presentation/widgets/load_members/emty_result_for_searching_member.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_circular_to_load_members.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_error_to_load_members.dart';
import 'package:association_appli/presentation/widgets/member_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeniorsMembersPage extends StatefulWidget {
  const SeniorsMembersPage({super.key});

  @override
  State<SeniorsMembersPage> createState() => _SeniorsMembersPageState();
}

class _SeniorsMembersPageState extends State<SeniorsMembersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MemberProviders>(
        context,
        listen: false,
      ).getMembersByStatus(category: 'Ancien');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWidget(
        context: context,
        icon: 'assets/icons/arrowleftt.png',
        title: 'Anciens',
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
          if (provider.state == MemberState.loading) {
            return widgetCircularToLoadMembers();
          }

          if (provider.state == MemberState.error) {
            return widgetErrorToLoadMembers(provider: provider);
          }

          final seniorMembers =
              provider.searchedMembers.isNotEmpty
                  ? provider.searchedMembers
                  : provider.members;

          bool canInitializeLoad =
              provider.members.isEmpty && !provider.searchedMembers.isNotEmpty;

          return _getAndDisplaySeniorMembers(
            seniorList: seniorMembers,
            isSearching: provider.searchedMembers.isNotEmpty,
            isInitialLoadempty: canInitializeLoad,
          );
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

  Widget _getAndDisplaySeniorMembers({
    required List<MemberEntity> seniorList,
    required bool isSearching,
    required bool isInitialLoadempty,
  }) {
    final status = 'Ancien';
    if (isInitialLoadempty) {
      return emptyResultForSearchingMember(
        title: 'Aucun Ancien trouvé',
        status: status,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: InputSearchMembers(category: status),
        ),
        SizedBox(height: 12.0),
        Expanded(
          child:
              seniorList.isEmpty && isSearching
                  ? emptyResultAndElderMemberNotFound(status: status)
                  : _showSeniorMembers(seniorList: seniorList),
        ),
      ],
    );
  }

  Widget _showSeniorMembers({required List<MemberEntity> seniorList}) {
    return ListView.builder(
      itemCount: seniorList.length,
      itemBuilder: (context, index) {
        return MemberItemWidget(memberEntity: seniorList[index]);
      },
    );
  }
}
