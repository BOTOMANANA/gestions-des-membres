// ignore_for_file: non_constant_identifier_names
import 'package:association_appli/domain/entities/product_entity.dart';
import 'package:flutter/foundation.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.activityId,
    required super.name,
    required super.price,
    required super.requiredTickets,
    required super.createAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      activityId: json['activity_id'],
      name: json['name'],
      price: json['price'],
      requiredTickets: json['required_tickets'],
      createAt: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'member_id': activeDevToolsServerAddress,
      'name': name,
      'price': price,
      'required_tickets': requiredTickets,
      'date': createAt,
    };
  }

  factory ProductModel.fromEntity({required ProductEntity productEntity}) {
    return ProductModel(
      id: productEntity.id,
      activityId: productEntity.activityId,
      name: productEntity.name,
      price: productEntity.price,
      requiredTickets: productEntity.requiredTickets,
      createAt: productEntity.createAt,
    );
  }
}
