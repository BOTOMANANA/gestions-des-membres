class ActivityEntity {
  int? id;
  String name;
  DateTime startDate;
  DateTime endDate;
  String location;

  ActivityEntity({
    this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.location,
  });
}
