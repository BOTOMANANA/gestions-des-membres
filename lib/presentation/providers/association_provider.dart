import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/association_entity.dart';
import 'package:association_appli/domain/usecases/association_usecases/create_association_usecase.dart';
import 'package:association_appli/domain/usecases/association_usecases/get_association_usecase.dart';
import 'package:flutter/material.dart';

enum AssociationState { initial, loading, loaded, error }

class AssociationProvider extends ChangeNotifier {
  final CreateAssociationUsecase createAssociationUsecase;
  final GetAssociationUsecase getAssociationUsecase;

  AssociationProvider({
    required this.createAssociationUsecase,
    required this.getAssociationUsecase,
  });

  AssociationState _state = AssociationState.initial;
  late AssociationEntity _association;
  String? _errorMessage;
  AssociationState get state => _state;
  String? get erroMessage => _errorMessage;
  AssociationEntity get assocition => _association;

  void _handleFailure({required Failure failure}) {
    _errorMessage = failure.errorMessage;
    _setState(newState: AssociationState.error);
  }

  void _setState({required AssociationState newState}) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchAssocition() async {
    var result = await getAssociationUsecase();
    result.fold(
      (failure) {
        _handleFailure(failure: failure);
      },
      (associationEntity) {
        _association = associationEntity;
        _setState(newState: AssociationState.loaded);
      },
    );
  }

  Future<void> createAssociation({
    required AssociationEntity associationEntity,
  }) async {
    var result = await createAssociationUsecase(association: associationEntity);
    result.fold(
      (failure) {
        _handleFailure(failure: failure);
      },
      (_) {
        _setState(newState: AssociationState.loaded);
      },
    );
  }
}
