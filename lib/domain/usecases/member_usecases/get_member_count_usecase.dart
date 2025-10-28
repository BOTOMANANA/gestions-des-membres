import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/repositories/member_repository.dart';
import 'package:dartz/dartz.dart';

class GetMemberCountUsecase {
  MemberRepository repository;
  GetMemberCountUsecase({required this.repository});
  Future<Either<Failure, int>> call() async {
    return await repository.getMembersCountRepository();
  }
}
