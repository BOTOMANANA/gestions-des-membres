// ignore_for_file: file_names
import 'package:association_appli/domain/entities/member_product_status_entity.dart';

class MemberProductStatusModel extends MemberProductStatusEntity {
  const MemberProductStatusModel({
    super.id,
    required super.activityProductId,
    required super.memberId,
    required super.ticketNumber,
    required super.isPayed,
  });

  factory MemberProductStatusModel.fromJson(Map<String, dynamic> json) {
    return MemberProductStatusModel(
      id: json['id'] as int?,
      activityProductId: json['activity_product_id'] as int,
      memberId: json['member_id'] as int,
      ticketNumber: json['tickes_number'] as int,
      // La DB stocke un INTEGER (0 ou 1) pour is_payed, nous le convertissons en bool.
      isPayed: (json['is_payed'] as int) == 1,
    );
  }

  // Convertit un Model en Map pour l'insertion/mise à jour DB
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'activity_product_id': activityProductId,
      'member_id': memberId,
      'tickes_number': ticketNumber,
      // Conversion de bool en INTEGER (1 ou 0) pour la DB
      'is_payed': isPayed ? 1 : 0,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory MemberProductStatusModel.fromEntity(
    MemberProductStatusEntity entity,
  ) {
    return MemberProductStatusModel(
      id: entity.id,
      activityProductId: entity.activityProductId,
      memberId: entity.memberId,
      ticketNumber: entity.ticketNumber,
      isPayed: entity.isPayed,
    );
  }
}
