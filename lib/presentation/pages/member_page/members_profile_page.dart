// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/utils/number_formatter.dart';
import 'package:association_appli/presentation/widgets/build_label_between_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/providers/single_member_provider.dart';
import 'package:association_appli/presentation/widgets/create_text_widget.dart';
import 'package:association_appli/presentation/widgets/custom_appbar_widget.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_error_state_placeholder.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_loading_indicator.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_member_profile_image.dart';
import 'package:association_appli/presentation/widgets/members_widgets/profile/display_member_product_activity.dart';
import 'package:association_appli/presentation/widgets/members_widgets/profile/member_contribution_summary.dart';
import 'package:association_appli/presentation/widgets/members_widgets/profile/member_information_horizontal_list.dart';
import 'package:association_appli/presentation/widgets/members_widgets/profile/profile_action_buttons.dart';

class MembersProfilePage extends StatefulWidget {
  final int id;
  const MembersProfilePage({super.key, required this.id});

  @override
  State<MembersProfilePage> createState() => _MembersProfilePageState();
}

class _MembersProfilePageState extends State<MembersProfilePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SingleMemberProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getMemberById(id: widget.id);
    });

    return Scaffold(
      appBar: customAppBarWidget(
        context: context,
        icon: 'assets/icons/arrowleftt.png',
        title: 'Profile',
        background: Colors.white,
        actions: [ProfileActionButtons()],
      ),
      backgroundColor: Colors.white,
      body: Consumer<SingleMemberProvider>(
        builder: (context, provider, _) {
          if (provider.state == SingleMemberState.loading) {
            return buildLoadingIndicator();
          }

          if (provider.state == SingleMemberState.error) {
            String errorMessage = provider.errorMessage;
            return buildErrorStatePlaceholder(errorMessage: errorMessage);
          }

          if (provider.state == SingleMemberState.succes) {
            final member = provider.memberEntity!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMemberHeaderSection(provider: provider),
                  const SizedBox(height: 8.0),

                  BuildLabelBetweenSection(
                    leftLabel: 'Information',
                    leftLabelColor: LightThemeColors.colorPrimary,
                    rightLabel: '',
                    rightLabelColor: LightThemeColors.textFieldBorderColors,
                    onPressed: null,
                  ),

                  MemberInformationHorizontalList(member: member),
                  const SizedBox(height: 8.0),
                  BuildLabelBetweenSection(
                    leftLabel: 'Activites',
                    leftLabelColor: LightThemeColors.colorPrimary,
                    rightLabel: 'Voir tout',
                    rightLabelColor: LightThemeColors.textFieldBorderColors,
                    onPressed: null,
                  ),

                  DisplayMemberProductActivity(),
                  DisplayMemberProductActivity(),
                  DisplayMemberProductActivity(),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Stack _buildMemberHeaderSection({required SingleMemberProvider provider}) {
    return Stack(
      children: [
        Container(
          height: 232.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: LightThemeColors.colorPrimary,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          right: 173,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
            child: Image.asset(
              'assets/images/backgroundcard.png',
              height: 232.0,
              color: Colors.white.withOpacity(0.4),
              colorBlendMode: BlendMode.modulate,
            ),
          ),
        ),
        Positioned.fill(
          child: Center(child: _buildMemberIdentitySection(provider: provider)),
        ),
      ],
    );
  }

  Widget _buildMemberIdentitySection({required SingleMemberProvider provider}) {
    final member = provider.memberEntity!;
    final freeShip = NumberFormatter.formatAmount(
      amount: member.memberShipFee,
      symbol: ' Ar',
    );
    return Column(
      children: [
        SizedBox(height: 12),
        Container(
          width: 90.0,
          height: 90.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(80.0),
          ),

          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: buildMemberProfileImage(
              member: member,
              size: 70.0,
              folderPath: '/storage/emulated/0/Picture',
            ),
          ),
        ),
        SizedBox(height: 8.0),
        CreateTextWidget.buildTextWidget(
          data: member.fullName,
          color: Colors.white,
          size: 16.0,
          weight: FontWeight.bold,
        ),
        SizedBox(height: 4.0),
        CreateTextWidget.buildTextWidget(
          data: member.category ?? 'Aucun(ne)',
          color: Colors.white54,
          size: 12.0,
          weight: FontWeight.w600,
        ),
        SizedBox(height: 20.0),
        MemberContributionSummary(freeShip: freeShip, social: 0, activities: 0),
      ],
    );
  }
}
