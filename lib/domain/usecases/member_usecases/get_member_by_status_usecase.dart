// ignore_for_file: dead_code

import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/domain/repositories/member_repository.dart';
import 'package:dartz/dartz.dart';

class GetMemberByStatusUsecase {
  MemberRepository repository;
  GetMemberByStatusUsecase({required this.repository});

  Future<Either<Failure, List<MemberEntity>>> call({
    required String memberCategory,
  }) async {
    return await repository.getMembersByStatusRepository(
      memberCategory: memberCategory,
    );
  }
}
