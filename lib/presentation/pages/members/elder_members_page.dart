import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/show_confirm_delete_dialog.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_floating_button.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/custom_appbar_widget.dart';
import 'package:association_appli/presentation/widgets/input_search_members.dart';
import 'package:association_appli/presentation/widgets/member_item_widget.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_error_state_placeholder.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_loading_indicator.dart';
import 'package:association_appli/presentation/widgets/members_widgets/members_load_status_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ElderMembersPage extends StatefulWidget {
  const ElderMembersPage({super.key});

  @override
  State<ElderMembersPage> createState() => _OlderMembersPageState();
}

class _OlderMembersPageState extends State<ElderMembersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MemberProviders>(
        context,
        listen: false,
      ).getMembersByStatus(category: 'Doyen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWidget(
        context: context,
        icon: 'assets/icons/arrowleftt.png',
        title: 'Doyens',
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
            return buildLoadingIndicator();
          }

          if (provider.state == MemberState.error) {
            String message = provider.errorMessage;
            return buildErrorStatePlaceholder(errorMessage: message);
          }

          final memberToDisplay =
              provider.searchedMembers.isNotEmpty
                  ? provider.searchedMembers
                  : provider.members;

          bool isListInitiallyEmpty =
              provider.members.isEmpty && !provider.searchedMembers.isNotEmpty;

          return _getAndDisplayElderMembers(
            elderList: memberToDisplay,
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

  Widget _getAndDisplayElderMembers({
    required List<MemberEntity> elderList,
    required bool isSearching,
    required bool isInitialLoadEmpty,
  }) {
    final status = 'Doyen';
    if (isInitialLoadEmpty) {
      return buildSearchNoResultsPlaceholder(
        title: 'Aucun doyen trouvé',
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
              elderList.isEmpty && isSearching
                  ? buildInitialEmptyStatePlaceholder(status: status)
                  : _showElderMembers(elderList: elderList),
        ),
      ],
    );
  }

  Widget _showElderMembers({required List<MemberEntity> elderList}) {
    return ListView.builder(
      itemCount: elderList.length,
      itemBuilder: (context, index) {
        return MemberItemWidget(memberEntity: elderList[index]);
      },
    );
  }
}
