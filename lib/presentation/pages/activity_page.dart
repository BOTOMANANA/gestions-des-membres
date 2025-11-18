import 'package:association_appli/presentation/widgets/alert_dialog_widgets/show_create_activity_dialog.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
      floatingActionButton: customFloatingButtonWithText(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ShowCreateActivityDialog(),
          );
        },
        icon: 'assets/icons/call.png',
        title: 'Créer activité',
        buttonSize: 200.0,
      ),
    );
  }
}
