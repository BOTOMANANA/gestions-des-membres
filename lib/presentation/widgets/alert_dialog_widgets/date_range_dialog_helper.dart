// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class DateRangeDialogHelper {
  static Future<List<DateTime?>?> showDateRangePicker({
    required BuildContext context,
    required List<DateTime?> initialDates,
  }) async {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: LightThemeColors.colorPrimary,
      cancelButton: _buildTextAction(title: 'Annuler', color: Colors.black87),
      okButton: _buildTextAction(
        title: 'Confirmer',
        color: LightThemeColors.colorPrimary,
      ),
    );

    final results = await showCalendarDatePicker2Dialog(
      dialogBackgroundColor: Colors.white,
      context: context,
      config: config,
      dialogSize: const Size(325.0, 400.0),
      borderRadius: BorderRadius.circular(16.0),
      value: initialDates,
    );

    return results;
  }

  static Text _buildTextAction({required String title, required Color color}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: AppFonts.robotoCondensedFont(
        size: 14.0,
        color: color,
        weight: FontWeight.w500,
      ),
    );
  }
}
