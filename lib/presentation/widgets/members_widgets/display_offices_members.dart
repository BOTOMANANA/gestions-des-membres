// ignore_for_file: public_member_api_docs, sort_constructors_first, library_prefixes
import 'dart:math' as Math;
import 'package:association_appli/presentation/widgets/members_widgets/member_office_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:association_appli/domain/entities/member_entity.dart';

class DisplayOfficesMembers extends StatelessWidget {
  final List<MemberEntity> memberList;
  const DisplayOfficesMembers({super.key, required this.memberList});

  @override
  Widget build(BuildContext context) {
    const int maxItemsToShow = 4;
    final int itemCount = Math.min(memberList.length, maxItemsToShow);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_memberOfficeCard(itemCount: itemCount)],
    );
  }

  Expanded _memberOfficeCard({required int itemCount}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return MemberOfficeItemWidget(memberEntity: memberList[index]);
          },
        ),
      ),
    );
  }
}
