import 'package:association_appli/core/errors/failure.dart';
import 'package:association_appli/domain/entities/activity_entity.dart';
import 'package:association_appli/domain/usecases/activity_usecases/create_activity_usecase.dart';
import 'package:association_appli/domain/usecases/activity_usecases/delete_activity_usecase.dart';
import 'package:association_appli/domain/usecases/activity_usecases/get_all_acitvity_usecase.dart';
import 'package:flutter/material.dart';

enum ActivityState { initial, loading, loaded, error }

class ActivityProvider extends ChangeNotifier {
  final GetAllAcitvityUsecase getAllAcitvityUsecase;
  final CreateActivityUsecase createActivityUsecase;
  final DeleteActivityUsecase deleteActivityUsecase;

  ActivityProvider({
    required this.getAllAcitvityUsecase,
    required this.createActivityUsecase,
    required this.deleteActivityUsecase,
  });

  ActivityState _state = ActivityState.initial;
  List<ActivityEntity> _activities = [];
  String? _errorMessage;

  ActivityState get state => _state;
  List<ActivityEntity> get activities => _activities;
  String? get errorMessage => _errorMessage;

  void _handleFailure({required Failure failure}) {
    _errorMessage = failure.errorMessage;
    _setState(ActivityState.error);
    notifyListeners();
  }

  void _setState(ActivityState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchAllActivities() async {
    _setState(ActivityState.loading);

    final result = await getAllAcitvityUsecase();
    result.fold(
      (failure) {
        _handleFailure(failure: failure);
      },
      (activitiesList) {
        _activities = activitiesList;
        _setState(ActivityState.loaded);
      },
    );
  }

  Future<void> createActivity({required ActivityEntity activity}) async {
    _setState(ActivityState.loading);

    final result = await createActivityUsecase(activityEntity: activity);
    result.fold(
      (failure) {
        _handleFailure(failure: failure);
      },
      (_) async {
        await fetchAllActivities();
      },
    );
  }

  Future<void> deleteActivity({required int id}) async {
    _setState(ActivityState.loading);

    final result = await deleteActivityUsecase(id: id);
    result.fold(
      (failure) {
        _handleFailure(failure: failure);
      },
      (_) async {
        await fetchAllActivities();
      },
    );
  }
}
