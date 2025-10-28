import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MemberRepository {
  Future<Either<Failure, List<MemberEntity>>> getMembersRepository();
  Future<Either<Failure, int>> getMembersCountRepository();
  Future<Either<Failure, List<MemberEntity>>> getMembersByStatusRepository({
    required MemberStatus status,
  });
  Future<Either<Failure, MemberEntity>> getMemberByIdRepository({
    required int id,
  });
  Future<Either<Failure, void>> createMemberRepository({
    required MemberEntity memberEntity,
  });
  Future<Either<Failure, void>> updateMemberRepository({
    required MemberEntity memberEntity,
  });
  Future<Either<Failure, void>> deleteMemberRepository({required int id});
  Future<Either<Failure, List<MemberEntity>>> searchMemberRepository({
    required String fullName,
  });
}
