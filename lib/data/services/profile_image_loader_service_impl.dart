import 'dart:io';
import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/domain/services/profile_image_loader_service.dart';
import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileImageLoaderServiceImpl implements ProfileImageLoaderService {
  @override
  Future<Either<Failure, String?>> loadProfileImagePath({
    required MemberEntity member,
    required String folderPath,
  }) async {
    try {
      final hasPermission = await _requestStoragePermission();

      if (!hasPermission) {
        return const Right(null);
      }

      final filePath = '$folderPath/${member.fullName}.png';
      final imageFile = File(filePath);

      if (await imageFile.exists()) {
        return Right(filePath);
      } else {
        return const Right(null);
      }
    } catch (e) {
      return Left(
        failure(error: 'Failed to load image profile: ${e.toString()}'),
      );
    }
  }

  Future<bool> _requestStoragePermission() async {
    final status = await Permission.storage.status;
    if (status.isGranted) return true;
    final result = await Permission.storage.request();
    return result.isGranted;
  }
}
