// ignore_for_file: constant_identifier_names
import 'package:association_appli/domain/entities/product_entity.dart';

enum MemberStatus { NOVICE, ANCIEN, DOYEN }

class MemberEntity {
  final int? id;
  final String fullName;
  final String genre;
  final String country;
  final int cinNumber;
  final String phoneNumber;
  final String quarter;
  final String faculty;
  final String studentCardNumber;
  final MemberStatus status;
  final String memberResponsability;
  final double memberShipFee;
  final List<ProductEntity> products;

  MemberEntity({
    required this.id,
    required this.fullName,
    required this.genre,
    required this.country,
    required this.cinNumber,
    required this.phoneNumber,
    required this.faculty,
    required this.quarter,
    required this.studentCardNumber,
    required this.status,
    required this.memberResponsability,
    required this.memberShipFee,
    this.products = const [],
  });

  //   var novices = members.where((m) => m.status == MemberStatus.NOVICE).toList();
  // var seniors = members.where((m) => m.status == MemberStatus.SENIOR).toList();
}
