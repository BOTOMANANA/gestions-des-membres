import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/providers/generate_pdf_providers.dart';
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

class DisplayAllMembers extends StatefulWidget {
  const DisplayAllMembers({super.key});

  @override
  State<DisplayAllMembers> createState() => _DisplayAllMembersState();
}

class _DisplayAllMembersState extends State<DisplayAllMembers> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MemberProviders>(context, listen: false).getMembers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgetAppBar(
        context: context,
        icon: 'assets/icons/arrowleftt.png',
        title: 'Tous les membres',
        background: Colors.white,
        actions: [
          customIconButton(
            iconPath: 'assets/icons/filepdf.png',
            size: 16.0,
            onPressed: () {
              Provider.of<GeneratePdfProviders>(
                context,
                listen: false,
              ).generateAllMembersPdf();
            },
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

          final allMembers =
              provider.searchedMembers.isNotEmpty
                  ? provider.searchedMembers
                  : provider.members;

          if (allMembers.isEmpty) {
            return const Center(child: Text('aucun members a trouver'));
          }
          if (provider.state == MemberState.succes) {
            return _getAndDisplayAllMembers(allMemberList: allMembers);
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

  Widget _getAndDisplayAllMembers({required List<MemberEntity> allMemberList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: InputSearchMembers(category: ''),
        ),
        SizedBox(height: 12.0),
        Expanded(
          child: ListView.builder(
            itemCount: allMemberList.length,
            itemBuilder: (context, index) {
              return MemberItemWidget(memberEntity: allMemberList[index]);
            },
          ),
        ),
      ],
    );
  }
}
