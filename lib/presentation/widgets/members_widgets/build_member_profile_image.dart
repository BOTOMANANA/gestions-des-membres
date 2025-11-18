import 'dart:io';

import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Widget buildMemberProfileImage({
  required MemberEntity member,
  required double size,
  required String folderPath,
}) {
  return FutureBuilder<bool>(
    future: _requestStoragePermission(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return buildLoadingIndicator();
      }

      final hasPermission = snapshot.data ?? false;
      if (!hasPermission) {
        return _buildDefaultAvatar(member: member, size: size);
      }

      final imageFile = File('$folderPath/${member.fullName}.png');
      if (imageFile.existsSync()) {
        return _buildImageFromFile(
          member: member,
          image: imageFile,
          size: size,
        );
      } else {
        return _buildDefaultAvatar(member: member, size: size);
      }
    },
  );
}

Widget _buildImageFromFile({
  required MemberEntity member,
  required File image,
  required double size,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(size),
    child: Image.file(
      image,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder:
          (context, error, stackTrace) =>
              _buildDefaultAvatar(member: member, size: size),
    ),
  );
}

Widget _buildDefaultAvatar({
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

Future<bool> _requestStoragePermission() async {
  final status = await Permission.storage.status;
  if (status.isGranted) return true;
  final result = await Permission.storage.request();
  return result.isGranted;
}
