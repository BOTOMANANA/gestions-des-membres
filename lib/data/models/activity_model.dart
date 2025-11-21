import 'package:association_appli/domain/entities/activity_entity.dart';

class ActivityModel extends ActivityEntity {
  ActivityModel({
    required super.id,
    required super.name,
    required super.startDate,
    required super.endDate,
    required super.location,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      name: json['activity_name'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activity_name': name,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'location': location,
    };
  }

  factory ActivityModel.fromEntity({required ActivityEntity activityEntity}) {
    return ActivityModel(
      id: activityEntity.id,
      name: activityEntity.name,
      startDate: activityEntity.startDate,
      endDate: activityEntity.endDate,
      location: activityEntity.location,
    );
  }
}
