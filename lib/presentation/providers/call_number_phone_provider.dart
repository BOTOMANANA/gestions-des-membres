import 'package:flutter/foundation.dart';

import 'package:association_appli/domain/usecases/service_usecase/call_phone_number_service_usecase.dart';

class CallNumberPhoneProvider extends ChangeNotifier {
  final CallPhoneNumberServiceUsecase callPhoneNumberServiceUsecase;
  CallNumberPhoneProvider({required this.callPhoneNumberServiceUsecase});

  Future<void> callMember({required String contact}) async {
    await callPhoneNumberServiceUsecase.call(contact: contact);
    notifyListeners();
  }
}
