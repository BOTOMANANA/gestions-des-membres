class ProductEntity {
  final int id;
  final String name;
  final double price;
  final int ticketNumber;
  final int requiredTicket; // ticket obligatoire ou minimuim
  final DateTime createAt;
  final bool isPayed;

  ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.ticketNumber,
    required this.requiredTicket,
    required this.createAt,
    required this.isPayed,
  });
}
