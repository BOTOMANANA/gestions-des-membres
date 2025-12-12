import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileImageLoaderService {
  Future<Either<Failure, String?>> loadProfileImagePath({
    required MemberEntity member,
    required String folderPath,
  });
}
