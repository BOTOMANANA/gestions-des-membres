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
    const String categoryStatus = 'Novice';

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
            return buildLoadingIndicator();
          }

          if (provider.state == MemberState.error) {
            String message = provider.errorMessage;
            return buildErrorStatePlaceholder(errorMessage: message);
          }

          final bool isSearching = provider.isSearching;
          final List<MemberEntity> displayNoviceList =
              isSearching ? provider.searchedMembers : provider.members;

          final bool isCategoryDataEmpty =
              !isSearching && provider.members.isEmpty;

          return MemberListDisplay(
            memberList: displayNoviceList,
            isSearching: isSearching,
            isCategoryDataEmpty: isCategoryDataEmpty,
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
