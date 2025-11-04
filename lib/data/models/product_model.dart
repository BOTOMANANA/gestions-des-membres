// ignore_for_file: non_constant_identifier_names

import 'package:association_appli/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.memberId,
    required super.name,
    required super.price,
    required super.ticketNumber,
    required super.requiredTicket,
    required super.createAt,
    required super.isPayed,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      memberId: json['member_id'],
      name: json['name'],
      price: json['price'],
      ticketNumber: json['ticket_number'],
      requiredTicket: json['required_ticket'],
      createAt: json['date'],
      isPayed: json['is_payed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'member_id': memberId,
      'name': name,
      'price': price,
      'ticket_number': ticketNumber,
      'required_ticket': requiredTicket,
      'date': createAt,
      'is_payed': isPayed,
    };
  }

  factory ProductModel.fromEntity({required ProductEntity productEntity}) {
    return ProductModel(
      id: productEntity.id,
      memberId: productEntity.memberId,
      name: productEntity.name,
      price: productEntity.price,
      ticketNumber: productEntity.ticketNumber,
      requiredTicket: productEntity.requiredTicket,
      createAt: productEntity.createAt,
      isPayed: productEntity.isPayed,
    );
  }
}
