// ignore_for_file: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  static String formatDateRange(DateTime start, DateTime end) {
    // 1. Vérifie si le mois et l'année sont identiques
    final bool sameMonthAndYear =
        start.month == end.month && start.year == end.year;

    final DateFormat monthYearFormat = DateFormat('MM-yyyy'); // Ex: 11-2025
    final DateFormat dayFormat = DateFormat('dd'); // Ex: 25

    if (sameMonthAndYear) {
      final String monthYear = monthYearFormat.format(start);
      final String startDay = dayFormat.format(start);
      final String endDay = dayFormat.format(end);

      return '$startDay au $endDay - $monthYear';
    } else {
      // Format complet si les dates couvrent plusieurs mois/années
      final DateFormat fullDateFormat = DateFormat('dd MMM yyyy');
      final String startDate = fullDateFormat.format(start);
      final String endDate = fullDateFormat.format(end);

      return '$startDate au $endDate';
    }
  }
}
