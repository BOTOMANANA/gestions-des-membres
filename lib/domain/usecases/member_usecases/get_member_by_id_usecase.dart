import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/domain/repositories/member_repository.dart';
import 'package:dartz/dartz.dart';

class GetMemberByIdUsecase {
  final MemberRepository repository;
  GetMemberByIdUsecase({required this.repository});
  Future<Either<Failure, MemberEntity>> call({required int id}) async {
    return await repository.getMemberByIdRepository(id: id);
  }
}
