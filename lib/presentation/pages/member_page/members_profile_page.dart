// ignore_for_file: deprecated_member_use
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/providers/call_number_phone_provider.dart';
import 'package:association_appli/presentation/providers/single_member_provider.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/show_confirm_delete_dialog.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/show_qr_code_dialog.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/create_text_widget.dart';
import 'package:association_appli/presentation/widgets/custom_appbar_widget.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_error_state_placeholder.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_loading_indicator.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_member_profile_image.dart';
import 'package:association_appli/presentation/widgets/members_widgets/profile/member_contribution_summary.dart';
import 'package:association_appli/presentation/widgets/members_widgets/profile/member_information_horizontal_list.dart';
import 'package:association_appli/presentation/widgets/members_widgets/profile/profile_action_buttons.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MembersProfilePage extends StatefulWidget {
  final int id;
  const MembersProfilePage({super.key, required this.id});

  @override
  State<MembersProfilePage> createState() => _MembersProfilePageState();
}

class _MembersProfilePageState extends State<MembersProfilePage> {
  @override
  Widget build(BuildContext context) {
    // Récupère le provider global sans le recréer
    final provider = Provider.of<SingleMemberProvider>(context, listen: false);

    // Appelle getMemberById après la première frame pour éviter d'appeler notifyListeners dans build
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
                  _headerCardProfile(provider: provider),
                  const SizedBox(height: 16.0),
                  Text(
                    'Informations',
                    style: AppFonts.robotoFont(
                      size: 16.0,
                      color: LightThemeColors.colorPrimary,
                      weight: FontWeight.w600,
                    ),
                  ),
                  MemberInformationHorizontalList(member: member),
                  // _bodyOfPersonalInformation(member: member),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Activites',
                        style: AppFonts.robotoFont(
                          size: 16.0,
                          color: LightThemeColors.colorPrimary,
                          weight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () => ShowConfirmDeleteDialog(),
                        style: TextButton.styleFrom(
                          textStyle: AppFonts.robotoCondensedFont(
                            size: 12.0,
                            color: LightThemeColors.textFieldBorderColors,
                          ),
                        ),
                        child: Text('Voir tout'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  _cardActivityContainer(),
                  _cardActivityContainer(),
                  _cardActivityContainer(),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Stack _headerCardProfile({required SingleMemberProvider provider}) {
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
          child: Center(child: _displayPersonalInformation(provider: provider)),
        ),
      ],
    );
  }

  Widget _displayPersonalInformation({required SingleMemberProvider provider}) {
    final member = provider.memberEntity!;
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
        MemberContributionSummary(
          freeShip: member.memberShipFee,
          social: 0,
          activities: 0,
        ),
      ],
    );
  }
}

Widget _cardActivityContainer() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
    child: Container(
      width: 380.0,
      height: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: LightThemeColors.colorPrimary.withOpacity(0.16),
          width: 1,
        ),
      ),
    ),
  );
}

// class BuildAppBarAction extends StatelessWidget {
//   const BuildAppBarAction({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SingleMemberProvider>(
//       builder: (context, provider, child) {
//         if (provider.state != SingleMemberState.succes ||
//             provider.memberEntity == null) {
//           return const SizedBox.shrink();
//         }

//         final member = provider.memberEntity!;
//         final int contactInt = member.phoneNumber;
//         final String contact = contactInt.toString();

//         if (contactInt == 0) {
//           return SizedBox.shrink();
//         }

//         final callProvider = Provider.of<CallNumberPhoneProvider>(
//           context,
//           listen: false,
//         );

//         final String data = '''
//         {
//           "id":${member.id},
//           "nom":"${member.fullName}",
//           "phone": "$contact"
//         }
//         ''';

//         return Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             customIconButton(
//               iconPath: 'assets/icons/call.png',
//               size: 16.0,
//               onPressed: () {
//                 callProvider.callMember(contact: contact.toString());
//               },
//             ),
//             customIconButton(
//               iconPath: 'assets/icons/qrcode.png',
//               size: 16.0,
//               onPressed: () {
//                 ShowQrCodeDialog.showDialog(context: context, data: data);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
