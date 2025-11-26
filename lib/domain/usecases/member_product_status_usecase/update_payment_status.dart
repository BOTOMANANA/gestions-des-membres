// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/repositories/member_product_status_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePaymentStatus {
  final MemberProductStatusRepository repository;
  UpdatePaymentStatus({required this.repository});
  Future<Either<Failure, void>> call({
    required int statusId,
    required bool isPayed,
  }) async {
    return await repository.updatePaymentStatus(
      statusId: statusId,
      isPayed: isPayed,
    );
  }
}
