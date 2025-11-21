import 'package:association_appli/domain/entities/member_entity.dart';

class MemberModel extends MemberEntity {
  MemberModel({
    required super.id,
    required super.fullName,
    required super.genre,
    required super.country,
    required super.cinNumber,
    required super.phoneNumber,
    required super.faculty,
    required super.quarter,
    required super.studentCardNumber,
    required super.category,
    required super.memberResponsability,
    required super.memberShipFee,
    required super.createAt,
  });

  // on a besoin de ca dans la recuperation des donnees dans la base de donnee car la base donne de les data en model il faut donc transforme en json et cle-valeur et  en list enfin on des liste de model mais reste cle-valeur
  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'],
      fullName: json['full_name'],
      genre: json['genre'],
      country: json['country'],
      cinNumber: json['cin_number'],
      phoneNumber: json['phone_number'],
      faculty: json['faculty'],
      quarter: json['district'],
      studentCardNumber: json['student_card_number'],
      category: json['status'],
      memberResponsability: json['responsability'],
      memberShipFee: json['member_ship_free'],
      createAt:
          (json['created_at'] != null &&
                  json['created_at'].toString().isNotEmpty)
              ? DateTime.parse(json['created_at'])
              : DateTime.now(),
    );
  }

  //I need this for insert request sql
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'genre': genre,
      'country': country,
      'cin_number': cinNumber,
      'phone_number': phoneNumber,
      'faculty': faculty,
      'district': quarter,
      'student_card_number': studentCardNumber,
      'status': category,
      'responsability': memberResponsability,
      'member_ship_free': memberShipFee,
      'created_at': createAt?.toIso8601String(),
    };
  }

  // transformer mon objet enities en model car si je fait une ajout la base de donne ne connait directement car mon objet est en entities c'est ca mon objectif de transformer mon entities en model
  factory MemberModel.fromEntity({required MemberEntity memberEntity}) {
    return MemberModel(
      id: memberEntity.id,
      fullName: memberEntity.fullName,
      genre: memberEntity.genre,
      country: memberEntity.country,
      cinNumber: memberEntity.cinNumber,
      phoneNumber: memberEntity.phoneNumber,
      faculty: memberEntity.faculty,
      quarter: memberEntity.quarter,
      studentCardNumber: memberEntity.studentCardNumber,
      category: memberEntity.category,
      memberResponsability: memberEntity.memberResponsability,
      memberShipFee: memberEntity.memberShipFee,
      createAt: memberEntity.createAt,
    );
  }
}
