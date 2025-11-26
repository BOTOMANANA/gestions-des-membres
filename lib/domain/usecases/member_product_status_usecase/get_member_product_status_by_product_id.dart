// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/member_product_status_entity.dart';
import 'package:association_appli/domain/repositories/member_product_status_repository.dart';
import 'package:dartz/dartz.dart';

class GetMemberProductStatusByProductId {
  final MemberProductStatusRepository repository;
  GetMemberProductStatusByProductId({required this.repository});

  Future<Either<Failure, List<MemberProductStatusEntity>>> call({required int productId}) async {
    return await repository.getStatusByProductId(productId: productId);
  }
}
