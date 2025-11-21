import 'package:association_appli/domain/entities/activity_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityItemWidget extends StatelessWidget {
  final ActivityEntity activityEntity;

  const ActivityItemWidget({super.key, required this.activityEntity});

  // Méthode pour formater la date selon les règles demandées
  String _formatDateRange(DateTime start, DateTime end) {
    // 1. Vérifie si le mois et l'année sont identiques
    final bool sameMonthAndYear =
        start.month == end.month && start.year == end.year;

    final DateFormat monthYearFormat = DateFormat('MM-yyyy'); // Ex: 11-2025
    final DateFormat dayFormat = DateFormat('dd'); // Ex: 25

    if (sameMonthAndYear) {
      // Format concis : "25 au 30 -11- 2025"
      final String monthYear = monthYearFormat.format(start);
      final String startDay = dayFormat.format(start);
      final String endDay = dayFormat.format(end);

      return 'Du $startDay au $endDay - $monthYear';
    } else {
      // Format complet si les dates couvrent plusieurs mois/années
      final DateFormat fullDateFormat = DateFormat('dd MMM yyyy');
      final String startDate = fullDateFormat.format(start);
      final String endDate = fullDateFormat.format(end);

      return 'Du $startDate au $endDate';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Style des informations secondaires
    final infoStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]);

    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
    );

    // Récupération de la plage de dates formatée
    final String formattedDateRange = _formatDateRange(
      activityEntity.startDate,
      activityEntity.endDate,
    );

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Nom de l'Activité (Titre Principal)
            Text(
              activityEntity.name,
              style: titleStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(height: 16.0),

            // 2. Lieu de l'Activité
            Row(
              children: [
                const Icon(Icons.location_on, size: 18, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    activityEntity.location,
                    style: infoStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 3. Plage de Dates Formatée
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: Colors.blueGrey,
                ),
                const SizedBox(width: 8),
                Text(
                  formattedDateRange, // Utilisation du nouveau format
                  style: infoStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
