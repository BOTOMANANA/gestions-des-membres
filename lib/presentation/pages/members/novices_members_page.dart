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

class NovicesMembersPage extends StatefulWidget {
  const NovicesMembersPage({super.key});

  @override
  State<NovicesMembersPage> createState() => _NovicesMembersPageState();
}

class _NovicesMembersPageState extends State<NovicesMembersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MemberProviders>(
        context,
        listen: false,
      ).getMembersByStatus(category: 'Novice');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWidget(
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
          if (provider.state == MemberState.loading) {
            return widgetCircularToLoadMembers();
          }

          if (provider.state == MemberState.error) {
            return widgetErrorToLoadMembers(provider: provider);
          }

          final noviceMembers =
              provider.searchedMembers.isNotEmpty
                  ? provider.searchedMembers
                  : provider.members;

          bool isListInitiallyEmpty =
              provider.members.isEmpty && !provider.searchedMembers.isNotEmpty;

          return _getAndDisplayNoviceMembers(
            noviceList: noviceMembers,
            isSearching: provider.searchedMembers.isNotEmpty,
            isInitialLoadEmpty: isListInitiallyEmpty,
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

  Widget _getAndDisplayNoviceMembers({
    required List<MemberEntity> noviceList,
    required bool isSearching,
    required bool isInitialLoadEmpty,
  }) {
    final status = 'Novice';
    if (isInitialLoadEmpty) {
      return emptyResultForSearchingMember(
        title: 'Aucun novice trouvé',
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
              noviceList.isEmpty && isSearching
                  ? emptyResultAndElderMemberNotFound(status: status)
                  : _showNoviceMembers(noviceList: noviceList),
        ),
      ],
    );
  }

  Widget _showNoviceMembers({required List<MemberEntity> noviceList}) {
    return ListView.builder(
      itemCount: noviceList.length,
      itemBuilder: (context, index) {
        return MemberItemWidget(memberEntity: noviceList[index]);
      },
    );
  }
}
