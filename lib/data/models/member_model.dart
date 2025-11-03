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
    required super.status,
    required super.memberResponsability,
    required super.memberShipFee,
    required super.products,
  });

  // on a besoin de ca dans la recuperation des donnees dans la base de donnee car la base donne de les data en model il faut donc transforme en json et cle-valeur et  en list enfin on des liste de model mais reste cle-valeur
  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'],
      fullName: json['fullName'],
      genre: json['genre'],
      country: json['country'],
      cinNumber: json['cinNumber'],
      phoneNumber: json['phoneNumber'],
      faculty: json['faculty'],
      quarter: json['district'],
      studentCardNumber: json['studentCardNumber'],
      status: json['status'],
      memberResponsability: json['memberResponsability'],
      memberShipFee: json['memberShipFee'],
      products: json['products'],
    );
  }

  //j'utilise ca pour les donne inserer dans la base de donne soit comme cle-valeur json ou map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'genre': genre,
      'country': country,
      'cinNumber': cinNumber,
      'phoneNumber': phoneNumber,
      'faculty': faculty,
      'district': quarter,
      'studentCardNumber': studentCardNumber,
      'status': status,
      'memberResponsability': memberResponsability,
      'memberShipFree': memberShipFee,
      'products': products,
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
      status: memberEntity.status,
      memberResponsability: memberEntity.memberResponsability,
      memberShipFee: memberEntity.memberShipFee,
      products: [],
    );
  }
}
