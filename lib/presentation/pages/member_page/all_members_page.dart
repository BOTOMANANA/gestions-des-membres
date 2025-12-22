import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/providers/generate_pdf_providers.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/routes/page_routes.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/snack_bar_widget.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_floating_button.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/custom_appbar_widget.dart';
import 'package:association_appli/presentation/widgets/input_search_members.dart';
import 'package:association_appli/presentation/widgets/items_widgets/member_item_widget.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_error_state_placeholder.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_loading_indicator.dart';
import 'package:association_appli/presentation/widgets/state_placeholder_widgets/build_intial_empty_state_placeholder.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllMembersPage extends StatefulWidget {
  const AllMembersPage({super.key});

  @override
  State<AllMembersPage> createState() => _AllMembersPageState();
}

class _AllMembersPageState extends State<AllMembersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MemberProviders>(context, listen: false).getMembers();
    });
  }

  void exportPDF() {
    Provider.of<GeneratePdfProviders>(
      context,
      listen: false,
    ).generateAllMembersPdf();
    snackBarWidget(
      context: context,
      title: 'Exporter en pdf',
      type: ContentType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWidget(
        context: context,
        icon: 'assets/icons/arrowleftt.png',
        title: 'Tous les membres',
        background: Colors.white,
        actions: [
          customIconButton(
            iconPath: 'assets/icons/filepdf.png',
            size: 16.0,
            onPressed: () => exportPDF(),
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

          final members =
              provider.searchedMembers.isNotEmpty
                  ? provider.searchedMembers
                  : provider.members;

          if (members.isEmpty) {
            return Center(
              child: BuildIntialEmptyStatePlaceholder(
                title: 'Pas des membres',
                image: 'assets/images/emptyfolder.png',
                message:
                    'Aucun membres trouvé dans la base de donnee. Je suis desole!',
              ),
            );
          }
          if (provider.state == MemberState.succes) {
            return _getAndDisplayAllMembers(allMemberList: members);
          }
          return const Center();
        },
      ),
      floatingActionButton: CustomFloatingButton(
        onPressed: () => Navigator.pushNamed(context, PageRoutes.createMember),
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
        Expanded(child: _buildMembersList(allMemberList: allMemberList)),
      ],
    );
  }

  Widget _buildMembersList({required List<MemberEntity> allMemberList}) {
    return ListView.builder(
      itemCount: allMemberList.length,
      itemBuilder: (context, index) {
        return MemberItemWidget(memberEntity: allMemberList[index]);
      },
    );
  }
}
