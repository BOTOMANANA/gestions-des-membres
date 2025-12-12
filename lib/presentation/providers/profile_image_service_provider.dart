import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/domain/usecases/service_usecase/load_profile_image_service_usecase.dart';
import 'package:flutter/material.dart';

class ProfileImageServiceProvider extends ChangeNotifier {
  final LoadProfileImageServiceUsecase serviceUsecase;

  ProfileImageServiceProvider({required this.serviceUsecase});

  String? _imagePath;
  bool _isLoading = false;
  String? _errorMessage;

  String? get imagePath => _imagePath;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadProfileImage({
    required MemberEntity member,
    required String folderPath,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await serviceUsecase.call(
      member: member,
      folderPath: folderPath,
    );

    result.fold(
      (failure) {
        _errorMessage = failure.errorMessage;
        _imagePath = null;
      },
      (path) {
        _imagePath = path;
        _errorMessage = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }
}
