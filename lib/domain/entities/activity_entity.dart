class ActivityEntity {
  int? id;
  String activityName;
  DateTime startDate;
  DateTime endDate;
  String location;

  ActivityEntity({
    this.id,
    required this.activityName,
    required this.startDate,
    required this.endDate,
    required this.location,
  });
}
