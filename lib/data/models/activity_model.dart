import 'package:association_appli/domain/entities/activity_entity.dart';

class ActivityModel extends ActivityEntity {
  ActivityModel({
    required super.id,
    required super.activityName,
    required super.startDate,
    required super.endDate,
    required super.location,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      activityName: json['activity_name'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activity_name': activityName,
      'start_date': startDate,
      'end_date': endDate,
      'location': location,
    };
  }

  factory ActivityModel.fromEntity({required ActivityEntity activityEntity}) {
    return ActivityModel(
      id: activityEntity.id,
      activityName: activityEntity.activityName,
      startDate: activityEntity.startDate,
      endDate: activityEntity.endDate,
      location: activityEntity.location,
    );
  }
}
