// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/member_product_status_entity.dart';
import 'package:association_appli/domain/repositories/member_product_status_repository.dart';
import 'package:dartz/dartz.dart';

class SaveMemberProductStatus {
  final MemberProductStatusRepository repository;
  SaveMemberProductStatus({required this.repository});
  Future<Either<Failure, void>> call({
    required MemberProductStatusEntity status,
  }) async {
    return await repository.saveStatus(status: status);
  }
}
