// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class DateRangeExamplePage extends StatefulWidget {
  const DateRangeExamplePage({super.key});

  @override
  State<DateRangeExamplePage> createState() => _DateRangeExamplePageState();
}

class _DateRangeExamplePageState extends State<DateRangeExamplePage> {
  List<DateTime?> selectedDates = [];

  void pickDateRange() async {
    final results = await showCalendarDatePicker2Dialog(
      dialogBackgroundColor: Colors.white,
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        selectedDayHighlightColor: LightThemeColors.colorPrimary,
        cancelButton: Text(
          'Retour',
          textAlign: TextAlign.center,
          style: AppFonts.robotoCondensedFont(
            size: 14.0,
            color: Colors.black87,
          ),
        ),
      ),
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(16),
      value: selectedDates,
    );

    if (results != null) {
      setState(() {
        selectedDates = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final start = selectedDates.isNotEmpty ? selectedDates[0] : null;
    final end = selectedDates.length > 1 ? selectedDates[1] : null;

    return Scaffold(
      appBar: AppBar(title: Text("Date Range Picker Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickDateRange,
              child: Text("Choisir une période"),
            ),

            SizedBox(height: 20),

            if (start != null)
              Text(
                "Date début : ${start.toString().substring(0, 10)}",
                style: TextStyle(fontSize: 18),
              ),

            if (end != null)
              Text(
                "Date fin : ${end.toString().substring(0, 10)}",
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
