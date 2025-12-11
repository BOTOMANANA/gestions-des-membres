import 'package:association_appli/domain/services/call_phone_number_service.dart';

class CallPhoneNumberServiceUsecase {
  final CallPhoneNumberService callService;

  const CallPhoneNumberServiceUsecase({required this.callService});

  Future<void> call({required String contact}) async {
    await callService.callMember(contact: contact);
  }
}
