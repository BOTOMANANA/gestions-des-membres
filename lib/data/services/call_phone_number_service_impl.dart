import 'package:association_appli/core/errors/show_exception.dart';
import 'package:association_appli/domain/services/call_phone_number_service.dart';
import 'package:url_launcher/url_launcher.dart';

class CallPhoneNumberServiceImpl implements CallPhoneNumberService {
  @override
  Future<void> callMember({required String contact}) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: contact);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (e) {
      ShowException.printError(error: e.toString());
    }
  }
}
