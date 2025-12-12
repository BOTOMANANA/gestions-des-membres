// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:association_appli/presentation/widgets/create_text_widget.dart';
import 'package:flutter/material.dart';

class MemberContributionSummary extends StatelessWidget {
  final String freeShip;
  final int social;
  final int activities;

  const MemberContributionSummary({
    super.key,
    required this.freeShip,
    required this.social,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    final title = ['Adhesion', 'C.Socials', 'Activites'];
    final amount = [freeShip, social, activities];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(title.length, (index) {
        return Column(
          children: [
            CreateTextWidget.buildTextWidget(
              data: '${amount[index]}',
              color: Colors.white,
              size: 16.0,
              weight: FontWeight.bold,
            ),
            CreateTextWidget.buildTextWidget(
              data: title[index],
              color: Colors.white54,
              size: 12.0,
              weight: FontWeight.w600,
            ),
          ],
        );
      }),
    );
  }
}
