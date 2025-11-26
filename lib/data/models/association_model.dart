import 'package:association_appli/domain/entities/association_entity.dart';

class AssociationModel extends AssociationEntity {
  AssociationModel({
    super.id,
    required super.name,
    required super.slogan,
    required super.siege,
  });

  factory AssociationModel.fromJson({required Map<String, dynamic> json}) {
    return AssociationModel(
      id: json['id'],
      name: json['name'],
      slogan: json['slogan'],
      siege: json['siege'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'slogan': slogan, 'siege': siege};
  }

  factory AssociationModel.fromEntity({
    required AssociationEntity association,
  }) {
    return AssociationModel(
      id: association.id,
      name: association.name,
      slogan: association.slogan,
      siege: association.siege,
    );
  }
}
