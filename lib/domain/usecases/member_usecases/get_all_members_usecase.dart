import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/domain/repositories/member_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllMembersUsecase {
  MemberRepository repository;
  GetAllMembersUsecase({required this.repository});

  Future<Either<Failure, List<MemberEntity>>> call() async {
    return await repository.getMembersRepository();
  }
}
