import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/domain/services/profile_image_loader_service.dart';
import 'package:dartz/dartz.dart';

class LoadProfileImageServiceUsecase {
  final ProfileImageLoaderService imageLoaderService;

  const LoadProfileImageServiceUsecase({required this.imageLoaderService});

  Future<Either<Failure, String?>> call({
    required MemberEntity member,
    required String folderPath,
  }) async {
    return imageLoaderService.loadProfileImagePath(
      member: member,
      folderPath: folderPath,
    );
  }
}
