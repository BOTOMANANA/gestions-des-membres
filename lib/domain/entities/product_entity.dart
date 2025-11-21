class ProductEntity {
  final int id;
  final int activityId;
  final String name;
  final double price;
  final int requiredTickets; // ticket obligatoire ou minimuim
  final DateTime createAt;

  ProductEntity({
    required this.id,
    required this.activityId,
    required this.name,
    required this.price,
    required this.requiredTickets,
    required this.createAt,
  });
}
