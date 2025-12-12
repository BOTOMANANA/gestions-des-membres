import 'package:association_appli/domain/usecases/service_usecase/phone_service_usecase.dart';
import 'package:flutter/foundation.dart';

class PhoneServiceProvider extends ChangeNotifier {
  final PhoneServiceUsecase phoneServiceUsecase;
  PhoneServiceProvider({required this.phoneServiceUsecase});

  Future<void> callMember({required String contact}) async {
    await phoneServiceUsecase.call(contact: contact);
    notifyListeners();
  }
}
