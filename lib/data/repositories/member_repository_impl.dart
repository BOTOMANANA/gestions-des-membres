// ignore_for_file: dead_code

import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/data/datasources/member_local_datasources.dart';
import 'package:association_appli/data/models/member_model.dart';
import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/domain/repositories/member_repository.dart';
import 'package:dartz/dartz.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberLocalDatasources memberLocalDatasources;
  MemberRepositoryImpl({required this.memberLocalDatasources});

  @override
  Future<Either<Failure, void>> createMemberRepository({
    required MemberEntity memberEntity,
  }) async {
    try {
      await memberLocalDatasources.createMember(
        memberModel: MemberModel.fromEntity(memberEntity: memberEntity),
      );

      return Right(null);
    } catch (e) {
      return Left(
        DatabaseFailure(errorMessage: 'Sorry failure to create member $e'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteMemberRepository({
    required int id,
  }) async {
    try {
      await memberLocalDatasources.deleteMember(id: id);
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Error to delete a member'));
    }
  }

  @override
  Future<Either<Failure, MemberEntity>> getMemberByIdRepository({
    required int id,
  }) async {
    try {
      return Right(await memberLocalDatasources.getMemberById(id: id));
    } catch (e) {
      return Left(
        DatabaseFailure(errorMessage: 'Failure to get single member'),
      );
    }
  }

  @override
  Future<Either<Failure, List<MemberEntity>>> getMembersByStatusRepository({
    required String memberCategory,
  }) async {
    try {
      return Right(
        await memberLocalDatasources.getMemberByStatus(
          memberCategory: memberCategory,
        ),
      );
    } catch (e) {
      return Left(
        DatabaseFailure(
          errorMessage: 'Failure to get the list of members status',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<MemberEntity>>> getMembersRepository() async {
    try {
      return Right(await memberLocalDatasources.getAllMembers());
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Failure to get all members'));
    }
  }

  @override
  Future<Either<Failure, void>> updateMemberRepository({
    required MemberEntity memberEntity,
  }) async {
    try {
      await memberLocalDatasources.updateMember(
        memberModel: MemberModel.fromEntity(memberEntity: memberEntity),
      );
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure(errorMessage: 'Failure to update a member'));
    }
  }

  @override
  Future<Either<Failure, List<MemberEntity>>> searchMemberRepository({
    required String fullName,
  }) async {
    try {
      return Right(
        await memberLocalDatasources.searchMembers(fullName: fullName),
      );
    } catch (e) {
      return Left(
        DatabaseFailure(errorMessage: 'Member is not in the data base $e'),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getMembersCountRepository() async {
    try {
      int counts = await memberLocalDatasources.getMemberCount();
      return Right(counts);
    } catch (e) {
      return Left(
        DatabaseFailure(
          errorMessage: 'failure to get the number total of member',
        ),
      );
    }
  }
}
