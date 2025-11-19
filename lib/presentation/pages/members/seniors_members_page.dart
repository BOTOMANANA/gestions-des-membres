import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/show_confirm_delete_dialog.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_floating_button.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/custom_appbar_widget.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_error_state_placeholder.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_loading_indicator.dart';
import 'package:association_appli/presentation/widgets/members_widgets/members_list_display.dart';
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
    final categoryStatus = 'Ancien';
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
            return buildLoadingIndicator();
          }

          if (provider.state == MemberState.error) {
            String message = provider.errorMessage;
            return buildErrorStatePlaceholder(errorMessage: message);
          }

          final bool isSearching = provider.isSearching;
          final bool isDataEmpty = !isSearching && provider.members.isEmpty;
          final List<MemberEntity> displaySeniorList =
              isSearching ? provider.searchedMembers : provider.members;

          return MemberListDisplay(
            memberList: displaySeniorList,
            isSearching: isSearching,
            isCategoryDataEmpty: isDataEmpty,
            categoryStatus: categoryStatus,
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
}
