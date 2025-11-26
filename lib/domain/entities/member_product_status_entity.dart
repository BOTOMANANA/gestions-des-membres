class MemberProductStatusEntity {
  final int? id;
  final int activityProductId; // Clé étrangère vers le produit
  final int memberId; // Clé étrangère vers le membre
  final int ticketNumber; // Nombre d'unités (tickets) achetées
  final bool isPayed; // Statut de paiement (true si payé, false  sinon)

  const MemberProductStatusEntity({
    this.id,
    required this.activityProductId,
    required this.memberId,
    required this.ticketNumber,
    required this.isPayed,
  });
}
