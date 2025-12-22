import 'package:flutter/material.dart';

import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_member_profile_image.dart';

class BuildProfileBottomSheet extends StatelessWidget {
  final MemberEntity member;
  const BuildProfileBottomSheet({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: buildMemberProfileImage(
            member: member,
            size: 100.0,
            folderPath: '/storage/emulated/0/Picture',
          ),
        );
      },
    );
  }
}
