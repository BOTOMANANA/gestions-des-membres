import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:flutter/material.dart';

Widget imageMemberProfileRounded({
  required MemberEntity member,
  required double size,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(size),

    child: Image.asset(
      member.genre == 'Femme'
          ? 'assets/images/profilegirl.png'
          : 'assets/images/profileboy.png',
      width: size,
      height: size,
    ),
  );
}
