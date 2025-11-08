import 'dart:io';

import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/widgets/load_members/widget_circular_to_load_members.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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

Widget imageMemberProfileFile({
  required MemberEntity member,
  required double size,
  required String folderPath,
}) {
  return FutureBuilder<bool>(
    future: _alertDialogCheckStoragePermission(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return widgetCircularToLoadMembers();
      }

      final hasPermission = snapshot.data ?? false;
      if (!hasPermission) {
        return _defaultProfileImage(member: member, size: size);
      }

      final imageFile = File('$folderPath/${member.fullName}.png');
      if (imageFile.existsSync()) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: Image.file(
            imageFile,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, _) =>
                    _defaultProfileImage(member: member, size: size),
          ),
        );
      } else {
        return _defaultProfileImage(member: member, size: size);
      }
    },
  );
}

Widget _defaultProfileImage({
  required MemberEntity member,
  required double size,
}) {
  final defaultImage =
      member.genre == 'Femme'
          ? 'assets/images/profilegirl.png'
          : 'assets/images/profileboy.png';

  return ClipRRect(
    borderRadius: BorderRadius.circular(size),
    child: Image.asset(
      defaultImage,
      width: size,
      height: size,
      fit: BoxFit.cover,
    ),
  );
}

Future<bool> _alertDialogCheckStoragePermission() async {
  final status = await Permission.storage.status;
  if (status.isGranted) return true;
  final result = await Permission.storage.request();
  return result.isGranted;
}

Future<bool> _isSuperiorOr33() async {
  final status = await Permission.photos.status;
  if (status.isGranted) return true;
  final result = await Permission.photos.request();
  return result.isGranted;
}

Future<bool> _isInferior33() async {
  final status = await Permission.storage.status;
  if (status.isGranted) return true;
  final result = await Permission.storage.request();
  return result.isGranted;
}
