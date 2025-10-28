import 'package:association_appli/domain/entities/activity_entity.dart';

class ActivityModel extends ActivityEntity {
  ActivityModel({
    required super.id,
    required super.activityName,
    required super.startDate,
    required super.endDate,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      activityName: json['activityName'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activityName': activityName,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory ActivityModel.fromEntity({required ActivityEntity activityEntity}) {
    return ActivityModel(
      id: activityEntity.id,
      activityName: activityEntity.activityName,
      startDate: activityEntity.startDate,
      endDate: activityEntity.endDate,
    );
  }
}
