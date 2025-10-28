import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/domain/repositories/member_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateMemberUsecase {
  MemberRepository repository;
  UpdateMemberUsecase({required this.repository});

  Future<Either<Failure, void>> call({
    required MemberEntity memberEntity,
  }) async {
    return await repository.updateMemberRepository(memberEntity: memberEntity);
  }
}
