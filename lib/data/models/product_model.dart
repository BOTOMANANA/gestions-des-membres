import 'package:association_appli/domain/entities/product_entity.dart';

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
    final String dateString = json['date'] as String;

    return ProductModel(
      id: json['id'],
      activityId: json['activity_id'],
      name: json['name'],
      price: json['price'],
      requiredTickets: json['required_tickets'],
      createAt: DateTime.parse(dateString),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activity_id': activityId,
      'name': name,
      'price': price,
      'required_tickets': requiredTickets,
      'date': createAt.toIso8601String(),
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
