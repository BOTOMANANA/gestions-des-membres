import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/member_product_status_entity.dart';
import 'package:association_appli/domain/repositories/member_product_status_repository.dart';
import 'package:dartz/dartz.dart';

class MemberProductStatusRepositoryImpl implements MemberProductStatusRepository {
  @override
  Future<Either<Failure, List<MemberProductStatusEntity>>> getStatusByProductId({required int productId}) {
    // TODO: implement getStatusByProductId
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> saveStatus({required MemberProductStatusEntity status}) {
    // TODO: implement saveStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updatePaymentStatus({required int statusId, required bool isPayed}) {
    // TODO: implement updatePaymentStatus
    throw UnimplementedError();
  }

}