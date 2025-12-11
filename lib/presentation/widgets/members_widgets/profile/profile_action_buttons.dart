import 'package:association_appli/presentation/providers/call_number_phone_provider.dart';
import 'package:association_appli/presentation/providers/single_member_provider.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/show_qr_code_dialog.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileActionButtons extends StatelessWidget {
  const ProfileActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleMemberProvider>(
      builder: (context, provider, child) {
        if (provider.state != SingleMemberState.succes ||
            provider.memberEntity == null) {
          return const SizedBox.shrink();
        }

        final member = provider.memberEntity!;
        final int contactInt = member.phoneNumber;
        final String contact = contactInt.toString();

        if (contactInt == 0) {
          return SizedBox.shrink();
        }

        final callProvider = Provider.of<CallNumberPhoneProvider>(
          context,
          listen: false,
        );

        final String data = '''
        {
          "id":${member.id},
          "nom":"${member.fullName}",
          "phone": "$contact"
        }
        ''';

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            customIconButton(
              iconPath: 'assets/icons/call.png',
              size: 16.0,
              onPressed: () {
                callProvider.callMember(contact: contact.toString());
              },
            ),
            customIconButton(
              iconPath: 'assets/icons/qrcode.png',
              size: 16.0,
              onPressed: () {
                ShowQrCodeDialog.showDialog(context: context, data: data);
              },
            ),
          ],
        );
      },
    );
  }
}
