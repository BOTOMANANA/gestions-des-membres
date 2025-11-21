// ignore_for_file: constant_identifier_names

class MemberEntity {
  final int? id;
  final String fullName;
  final String genre;
  final String country;
  final int cinNumber;
  final int phoneNumber;
  final String quarter;
  final String faculty;
  final String studentCardNumber;
  final String? category;
  final String? memberResponsability;
  final int memberShipFee;
  DateTime? createAt;

  MemberEntity({
    this.id,
    required this.fullName,
    required this.genre,
    required this.country,
    required this.cinNumber,
    required this.phoneNumber,
    required this.faculty,
    required this.quarter,
    required this.studentCardNumber,
    this.category,
    this.memberResponsability,
    required this.memberShipFee,
    required this.createAt,
  });
}
