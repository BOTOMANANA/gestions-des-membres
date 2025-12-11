// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:flutter/material.dart';

import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/widgets/create_text_widget.dart';

class MemberInformationHorizontalList extends StatefulWidget {
  final MemberEntity member;
  const MemberInformationHorizontalList({super.key, required this.member});

  @override
  State<MemberInformationHorizontalList> createState() =>
      _MemberInformationHorizontalListState();
}

class _MemberInformationHorizontalListState
    extends State<MemberInformationHorizontalList> {
  @override
  Widget build(BuildContext context) {
    final iconsPath = [
      'assets/icons/graduationcard.png',
      'assets/icons/rapid.png',
      'assets/icons/creditcards.png',
    ];
    final title = [
      widget.member.faculty,
      widget.member.country,
      widget.member.quarter,
    ];

    final List<String> subTitle = [
      widget.member.studentCardNumber,
      '${widget.member.cinNumber}',
      ' ${widget.member.phoneNumber}',
    ];
    return SizedBox(
      height: 70.0,
      child: ListView.builder(
        itemCount: iconsPath.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Container(
              width: 190.0,
              height: 70.0,
              decoration: BoxDecoration(
                color: LightThemeColors.colorPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: MemberInfoCardItem(
                iconsAssets: iconsPath,
                infoTitles: title,
                infoSubtitles: subTitle,
                index: index,
              ),
            ),
          );
        },
      ),
    );
  }
}

class MemberInfoCardItem extends StatelessWidget {
  final List<String> iconsAssets;
  final List<String> infoTitles;
  final List<String> infoSubtitles;
  final int index;
  const MemberInfoCardItem({
    super.key,
    required this.iconsAssets,
    required this.infoTitles,
    required this.infoSubtitles,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 8.0),
        Image.asset(iconsAssets[index], width: 44.0, height: 44.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreateTextWidget.buildTextWidget(
                data: infoTitles[index],
                color: LightThemeColors.colorPrimary,
                size: 16.0,
                weight: FontWeight.w500,
              ),
              CreateTextWidget.buildTextWidget(
                data: infoSubtitles[index],
                color: LightThemeColors.colorPrimary.withOpacity(0.5),
                size: 12.0,
                weight: FontWeight.normal,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
