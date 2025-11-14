// ignore_for_file: deprecated_member_use

import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/providers/single_member_provider.dart';
import 'package:association_appli/presentation/widgets/alert_dialog/show_confirm_delete_dialog.dart';
import 'package:association_appli/presentation/widgets/alert_dialog/show_qr_code_dialog.dart';
import 'package:association_appli/presentation/widgets/button/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/load_members/get_image_profile_of_member_in_storage.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_circular_to_load_members.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_error_to_load_members.dart';
import 'package:association_appli/presentation/widgets/widget_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: widgetAppBar(
        context: context,
        icon: 'assets/icons/arrowleftt.png',
        title: 'Profile',
        background: Colors.white,
        actions: [_appBarAction()],
      ),
      backgroundColor: Colors.white,
      body: Consumer<SingleMemberProvider>(
        builder: (context, provider, _) {
          if (provider.state == SingleMemberState.loading) {
            return widgetCircularToLoadMembers();
          }

          if (provider.state == SingleMemberState.error) {
            return widgetErrorToLoadSingleMember(provider: provider);
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
                  _bodyOfPersonalInformation(member: member),
                  const SizedBox(height: 16.0),
                  Row(
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

  Widget _appBarAction() {
    return Consumer<SingleMemberProvider>(
      builder: (context, provider, child) {
        final member = provider.memberEntity;
        final String data =
            '"id":${member?.id},"nom":"${member!.fullName}","phone":"${member.phoneNumber}"';
        return Row(
          children: [
            customIconButton(
              iconPath: 'assets/icons/call.png',
              size: 16.0,
              onPressed: () {
                _callMember('${member.phoneNumber}');
              },
            ),
            customIconButton(
              iconPath: 'assets/icons/qrcode.png',
              size: 16.0,
              onPressed: () {
                ShowQrCodeDialog.showDialog(context: context, data: data);
              },
            ),
          ],
        );
      },
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
            child: getImageProfileMemberInStorageFile(
              member: member,
              size: 70.0,
              folderPath: '/storage/emulated/0/Picture',
            ),
          ),
        ),
        SizedBox(height: 8.0),
        titleTextFonts(
          data: member.fullName,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        SizedBox(height: 4.0),
        subTitleTextFonts(
          data: member.category ?? 'Aucun(ne)',
          color: Colors.white54,
        ),
        SizedBox(height: 20.0),
        _getAmountOfCotisation(
          freeShip: member.memberShipFee.toInt(),
          social: 0,
          amountActivity: 0,
        ),
      ],
    );
  }

  Widget _bodyOfPersonalInformation({required MemberEntity member}) {
    return Column(
      children: [
        SizedBox(height: 8.0),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _otherInformationPersonal(
                iconPath: 'assets/icons/graduationcard.png',
                firstData: member.faculty,
                lastData: member.studentCardNumber,
              ),
              SizedBox(width: 4.0),
              _otherInformationPersonal(
                iconPath: 'assets/icons/rapid.png',
                firstData: member.country,
                lastData: '${member.cinNumber}',
              ),
              SizedBox(width: 4.0),

              _otherInformationPersonal(
                iconPath: 'assets/icons/creditcards.png',
                firstData: member.faculty,
                lastData: member.studentCardNumber,
              ),
              SizedBox(width: 4.0),

              _otherInformationPersonal(
                iconPath: 'assets/icons/navigator.png',
                firstData: member.quarter,
                lastData: '',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Text titleTextFonts({
    required String data,
    required Color color,
    required FontWeight weight,
  }) {
    return Text(
      data,
      style: AppFonts.robotoFont(size: 16.0, color: color, weight: weight),
      overflow: TextOverflow.ellipsis,
    );
  }

  Text subTitleTextFonts({required String data, required Color color}) {
    return Text(
      data,
      style: AppFonts.robotoFont(
        size: 12.0,
        color: color,
        weight: FontWeight.w600,
      ),
    );
  }

  Row _getAmountOfCotisation({
    required int freeShip,
    required int social,
    required int amountActivity,
  }) {
    final titleCotisation = ['Adhesion', 'C.Socials', 'Activites'];
    final amounts = [freeShip, social, amountActivity];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(titleCotisation.length, (index) {
        return Column(
          children: [
            titleTextFonts(
              data: '${amounts[index]}',
              color: Colors.white,
              weight: FontWeight.bold,
            ),
            subTitleTextFonts(
              data: titleCotisation[index],
              color: Colors.white54,
            ),
          ],
        );
      }),
    );
  }

  Widget _otherInformationPersonal({
    required String iconPath,
    required String firstData,
    required String? lastData,
  }) {
    return Container(
      width: 190.0,
      height: 70.0,
      decoration: BoxDecoration(
        color: LightThemeColors.colorPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 8.0),
          Image.asset(iconPath, width: 44.0, height: 44.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleTextFonts(
                  data: firstData,
                  color: LightThemeColors.colorPrimary,
                  weight: FontWeight.w500,
                ),
                subTitleTextFonts(
                  data: lastData!,
                  color: LightThemeColors.colorPrimary.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ],
      ),
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

Future<void> _callMember(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Impossible de passe une appelle sur $phoneNumber';
  }
}
