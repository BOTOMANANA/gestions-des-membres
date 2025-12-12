import 'package:association_appli/domain/services/phone_service.dart';

class PhoneServiceUsecase {
  final PhoneService callService;

  const PhoneServiceUsecase({required this.callService});

  Future<void> call({required String contact}) async {
    await callService.callMember(contact: contact);
  }
}
