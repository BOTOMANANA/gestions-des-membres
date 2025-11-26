import 'package:association_appli/domain/entities/member_product_status_entity.dart';
import 'package:association_appli/domain/usecases/member_product_status_usecase/get_member_product_status_by_product_id.dart';
import 'package:association_appli/domain/usecases/member_product_status_usecase/save_member_product_status.dart';
import 'package:association_appli/domain/usecases/member_product_status_usecase/update_payment_status.dart';
import 'package:flutter/material.dart';

class MemberProductStatusProvider extends ChangeNotifier {
  // Dépendances (Use Cases)
  final SaveMemberProductStatus saveMemberProductStatus;
  final GetMemberProductStatusByProductId getStatusByProductId;
  final UpdatePaymentStatus updatePaymentStatus;

  MemberProductStatusProvider({
    required this.saveMemberProductStatus,
    required this.getStatusByProductId,
    required this.updatePaymentStatus,
  });

  // --- États du Provider ---
  bool _isLoading = false;
  String? _errorMessage;
  List<MemberProductStatusEntity> _statuses = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<MemberProductStatusEntity> get statuses => _statuses;

  // ID du produit actuellement chargé
  int? _currentProductId;
  int? get currentProductId => _currentProductId;
  // -------------------------

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // =========================================================================
  // 1. Récupération des statuts de paiement (pour afficher la liste et les checkboxes)
  // =========================================================================

  Future<void> fetchStatusByProductId(int productId) async {
    if (_currentProductId == productId && _statuses.isNotEmpty) {
      // Évite de recharger si l'ID est le même et la liste n'est pas vide (optimisation)
      return;
    }

    _currentProductId = productId;
    _setLoading(true);
    _setError(null);

    final result = await getStatusByProductId(productId: productId);

    result.fold(
      (failure) {
        _setError(failure.errorMessage);
        _statuses = [];
      },
      (data) {
        _statuses = data;
        _setError(null);
      },
    );

    _setLoading(false);
  }

  // =========================================================================
  // 2. Mise à jour du statut de paiement (via le Checkbox)
  // =========================================================================

  Future<void> togglePaymentStatus({
    required int statusId,
    required bool isPayed,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await updatePaymentStatus(
      statusId: statusId,
      isPayed: isPayed,
    );

    result.fold(
      (failure) {
        _setError(
          "Échec de la mise à jour du paiement: ${failure.errorMessage}",
        );
      },
      (_) {
        // Succès : Mise à jour de la liste locale pour refléter le changement
        final index = _statuses.indexWhere((s) => s.id == statusId);
        if (index != -1) {
          // Créer une nouvelle entité avec le statut mis à jour (Immuabilité)
          final updatedStatus = MemberProductStatusEntity(
            id: _statuses[index].id,
            activityProductId: _statuses[index].activityProductId,
            memberId: _statuses[index].memberId,
            ticketNumber: _statuses[index].ticketNumber,
            isPayed: isPayed, // Nouvelle valeur
          );
          _statuses[index] = updatedStatus;
          notifyListeners(); // Rafraîchit l'UI immédiatement
        }
      },
    );

    _setLoading(false);
  }

  // =========================================================================
  // 3. Sauvegarde d'un nouvel achat (réservation)
  // =========================================================================

  Future<bool> saveNewStatus(MemberProductStatusEntity status) async {
    _setLoading(true);
    _setError(null);

    final result = await saveMemberProductStatus(status: status);

    bool success = result.isRight();

    result.fold(
      (failure) {
        _setError(
          "Échec de l'enregistrement de l'achat: ${failure.errorMessage}",
        );
      },
      (_) {
        // En cas de succès, recharge la liste si nous sommes sur le bon produit
        if (status.activityProductId == _currentProductId) {
          // Note: Une nouvelle insertion peut avoir un nouvel ID.
          // La façon la plus simple de garantir l'affichage est de recharger
          // ou d'appeler une méthode de récupération plus spécifique.
          fetchStatusByProductId(status.activityProductId);
        }
      },
    );

    _setLoading(false);
    return success;
  }
}
