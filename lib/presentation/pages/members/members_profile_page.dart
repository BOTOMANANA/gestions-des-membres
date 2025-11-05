// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/providers/single_member_provider.dart';
import 'package:association_appli/presentation/widgets/button/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/load_members/image_member_profile.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_circular_to_load_members.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_error_to_load_members.dart';
import 'package:association_appli/presentation/widgets/widget_app_bar.dart';
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
      appBar: widgetAppBar(
        title: 'Profile',
        background: Colors.white,
        actions: [_appBarAction()],
      ),
      backgroundColor: Colors.white,
      body: Consumer<SingleMemberProvider>(
        builder: (context, provider, _) {
          if (provider.state == SingleMemberState.loading) {
            return widetCircularToLoadMembers();
          }

          if (provider.state == SingleMemberState.error) {
            return widgetErrorToLoadSingleMember(provider: provider);
          }

          if (provider.state == SingleMemberState.succes) {
            final member = provider.memberEntity!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cardProfile(provider: provider),
                  const SizedBox(height: 20),
                  Text(
                    'Experiences',
                    style: AppFonts.robotoFont(
                      size: 16.0,
                      color: LightThemeColors.colorPrimary,
                      weight: FontWeight.w600,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _otherInformationPersonal(
                          iconPath: 'assets/icons/graduationcard.png',
                          firstData: member.faculty,
                          lastData: member.studentCardNumber,
                        ),

                        _otherInformationPersonal(
                          iconPath: 'assets/icons/creditcard.png',
                          firstData: member.category ?? 'Aucun',
                          lastData: '${member.cinNumber}',
                        ),

                        _otherInformationPersonal(
                          iconPath: 'assets/icons/rapid.png',
                          firstData: member.faculty,
                          lastData: member.studentCardNumber,
                        ),

                        _otherInformationPersonal(
                          iconPath: 'assets/icons/navigator.png',
                          firstData: member.quarter,
                          lastData: null,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  _listAndAmountCotisation(
                    freeShip: member.memberShipFee.toInt(),
                    social: 0, // à adapter si tu as les valeurs
                    amountActivity: 0, // idem
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Row _appBarAction() {
    return Row(
      children: [
        customIconButton(iconPath: 'assets/icons/call.png', onPressed: () {}),
        SizedBox(width: 4),
        customIconButton(iconPath: 'assets/icons/qrcode.png', onPressed: () {}),
        SizedBox(width: 8),
      ],
    );
  }

  Stack _cardProfile({required SingleMemberProvider provider}) {
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
            ),
          ),
        ),
        Positioned.fill(
          child: Center(child: _personalInformation(provider: provider)),
        ),
      ],
    );
  }

  Widget _personalInformation({required SingleMemberProvider provider}) {
    final member = provider.memberEntity!;
    return Column(
      children: [
        SizedBox(height: 12),
        imageMemberProfileRounded(member: member, size: 90.0),
        SizedBox(height: 8.0),
        titleTextFonts(data: member.fullName),
        SizedBox(height: 4.0),
        subTitleTextFonts(data: member.country),
        SizedBox(height: 20.0),
        _listAndAmountCotisation(
          freeShip: member.memberShipFee.toInt(),
          social: 0,
          amountActivity: 0,
        ),
      ],
    );
  }

  Text titleTextFonts({required String data}) {
    return Text(
      data,
      style: AppFonts.robotoFont(
        size: 18.0,
        color: Colors.white,
        weight: FontWeight.bold,
      ),
    );
  }

  Text subTitleTextFonts({required String data}) {
    return Text(
      data,
      style: AppFonts.robotoFont(
        size: 12.0,
        color: Colors.white54,
        weight: FontWeight.w600,
      ),
    );
  }

  Row _listAndAmountCotisation({
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
            titleTextFonts(data: '${amounts[index]}'),
            subTitleTextFonts(data: titleCotisation[index]),
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
      width: 200.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: LightThemeColors.colorPrimary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 64.0, height: 64.0),
          SizedBox(width: 4.0),
          Column(
            children: [
              titleTextFonts(data: firstData),
              subTitleTextFonts(data: lastData!),
            ],
          ),
        ],
      ),
    );
  }
}
