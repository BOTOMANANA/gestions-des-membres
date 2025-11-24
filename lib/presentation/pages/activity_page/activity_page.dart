// ignore_for_file: use_build_context_synchronously
import 'package:association_appli/domain/entities/activity_entity.dart';
import 'package:association_appli/presentation/providers/activity_provider.dart';
import 'package:association_appli/presentation/widgets/custom_appbar_widget.dart';
import 'package:association_appli/presentation/widgets/items_widgets/activity_item_widget.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/show_create_activity_dialog.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_floating_button.dart';
import 'package:association_appli/presentation/widgets/members_widgets/build_loading_indicator.dart';
import 'package:association_appli/presentation/widgets/state_placeholder_widgets/build_error_state_placeholder.dart';
import 'package:association_appli/presentation/widgets/state_placeholder_widgets/build_intial_empty_state_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    super.initState();
    // Déclencher la récupération des activités dès que la page est initialisée.
    Future.microtask(() {
      Provider.of<ActivityProvider>(
        context,
        listen: false,
      ).fetchAllActivities();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ActivityProvider>();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: customAppBarWidget(
        context: context,
        title: 'Gestion des Activités',
        background: Colors.white,
        actions: [],
        icon: 'assets/icons/arrowleftt.png',
      ),
      body: _buildBody(context, provider),
      floatingActionButton: customFloatingButtonWithText(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ShowCreateActivityDialog(),
          );
        },
        icon: 'assets/icons/addactivity.png',
        title: 'Créer activité',
        width: 150.0,
      ),
    );
  }

  Widget _buildBody(BuildContext context, ActivityProvider provider) {
    switch (provider.state) {
      case ActivityState.loading:
        return buildLoadingIndicator();

      case ActivityState.error:
        return BuildErrorStatePlaceholder(
          message: 'Erreur lors du chargement des activités.',
          onPressed: () => provider.fetchAllActivities(),
        );

      case ActivityState.loaded:
        if (provider.activities.isEmpty) {
          return BuildIntialEmptyStatePlaceholder(
            title: '',
            image: 'assets/images/emptyfolder.png',
            message: 'Aucune activité trouvée. Créez-en une !',
          );
        }
        return _activityListToDisplay(activityProvider: provider);

      case ActivityState.initial:
        return buildLoadingIndicator();
    }
  }

  Widget _activityListToDisplay({required ActivityProvider activityProvider}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0).copyWith(bottom: 100.0),
      itemCount: activityProvider.activities.length,
      itemBuilder: (context, index) {
        final ActivityEntity activity = activityProvider.activities[index];
        return ActivityItemWidget(activityEntity: activity);
      },
    );
  }
}
