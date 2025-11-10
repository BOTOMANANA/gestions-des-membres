import 'package:association_appli/presentation/widgets/button/custom_icon_button.dart';
import 'package:association_appli/presentation/widgets/widget_app_bar.dart';
import 'package:flutter/material.dart';

class OlderMembersPage extends StatefulWidget {
  const OlderMembersPage({super.key});

  @override
  State<OlderMembersPage> createState() => _OlderMembersPageState();
}

class _OlderMembersPageState extends State<OlderMembersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgetAppBar(
        context: context,
        icon: 'assets/icons/arrowleftt.png',
        title: 'Doyens',
        background: Colors.white,
        actions: [
          customIconButton(
            iconPath: 'assets/icons/filepdf.png',
            size: 16.0,
            onPressed: () {},
          ),
          SizedBox(width: 8.0),
        ],
      ),
    );
  }
}
