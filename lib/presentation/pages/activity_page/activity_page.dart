import 'package:association_appli/domain/entities/activity_entity.dart';
import 'package:association_appli/presentation/providers/activity_provider.dart';
import 'package:association_appli/presentation/widgets/activity_item_widget.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/show_create_activity_dialog.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_floating_button.dart';
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
    // Utilisation de Future.microtask pour éviter les erreurs de "setstate during build"
    Future.microtask(
      () =>
          Provider.of<ActivityProvider>(
            context,
            listen: false,
          ).fetchAllActivities(),
    );
  }

  // Widget qui gère l'affichage en fonction de l'état du Provider
  Widget _buildBody(BuildContext context, ActivityProvider provider) {
    switch (provider.state) {
      case ActivityState.loading:
        return const Center(child: CircularProgressIndicator());

      case ActivityState.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                  size: 40,
                ),
                const SizedBox(height: 10),
                Text(
                  provider.errorMessage ??
                      'Erreur inconnue lors du chargement des activités.',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.redAccent),
                ),
                const SizedBox(height: 20),
                // Bouton pour réessayer le chargement
                ElevatedButton.icon(
                  onPressed: () => provider.fetchAllActivities(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        );

      case ActivityState.loaded:
        if (provider.activities.isEmpty) {
          return Center(
            child: Text(
              'Aucune activité trouvée. Créez-en une !',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        }

        // Affichage de la liste des activités
        return ListView.builder(
          padding: const EdgeInsets.all(
            16.0,
          ).copyWith(bottom: 100), // Espace pour le FAB
          itemCount: provider.activities.length,
          itemBuilder: (context, index) {
            final ActivityEntity activity = provider.activities[index];
            return ActivityItemWidget(activityEntity: activity);
          },
        );

      case ActivityState.initial:
      default:
        // Au cas où initState n'a pas encore déclenché l'appel, afficher le chargement.
        return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Utilisation de context.watch (équivalent à Consumer) pour reconstruire l'UI
    // dès que le Provider notifie un changement (chargement, données, erreur)
    final activityProvider = context.watch<ActivityProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[50], // Couleur de fond plus douce
      appBar: AppBar(
        title: const Text('Gestion des Activités'),
        centerTitle: true,
      ),
      body: _buildBody(context, activityProvider),

      floatingActionButton: customFloatingButtonWithText(
        onPressed: () {
          // Afficher la boîte de dialogue de création d'activité
          showDialog(
            context: context,
            builder: (context) => ShowCreateActivityDialog(),
          );
        },
        icon:
            'assets/icons/addactivity.png', // Assurez-vous que ce chemin d'icône est correct
        title: 'Créer activité',
        width: 150.0,
      ),
    );
  }
}
