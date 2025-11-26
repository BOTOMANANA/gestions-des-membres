import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/member_product_status_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MemberProductStatusRepository {
  Future<Either<Failure, void>> saveStatus({
    required MemberProductStatusEntity status,
  });
  Future<Either<Failure, List<MemberProductStatusEntity>>>
  getStatusByProductId({required int productId});
  Future<Either<Failure, void>> updatePaymentStatus({
    required int statusId,
    required bool isPayed,
  });
}
