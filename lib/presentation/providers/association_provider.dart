import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/association_entity.dart';
import 'package:flutter/material.dart';

enum AssociationState { initial, loading, loaded, error }

class AssociationProvider extends ChangeNotifier {
  AssociationState _state = AssociationState.initial;
  late AssociationEntity _entity;
  String? _errorMessage;
  AssociationState get state => _state;
  String? get erroMessage => _errorMessage;
  AssociationEntity get entity => _entity;

  void _handleFailure({required Failure failure}) {
    _errorMessage = failure.errorMessage;
    notifyListeners();
  }

  void _setState({required AssociationState newState}) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getFirstAssocition() async {}
  Future<void> createAssociation({
    required AssociationEntity association,
  }) async {}
}
