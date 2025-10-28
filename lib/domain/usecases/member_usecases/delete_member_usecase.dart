import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/repositories/member_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteMemberUsecase {
  MemberRepository repository;
  DeleteMemberUsecase({required this.repository});

  Future<Either<Failure, void>> call({required int id}) async {
    return await repository.deleteMemberRepository(id: id);
  }
}
