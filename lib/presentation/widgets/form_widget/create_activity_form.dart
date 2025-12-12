// ignore_for_file: must_be_immutable
import 'package:association_appli/presentation/utils/date_formatter.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/date_range_dialog_helper.dart';
import 'package:association_appli/presentation/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class CreateActivityForm extends StatefulWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateRangeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  CreateActivityForm({
    super.key,
    required this.nameController,
    required this.dateRangeController,
    required this.locationController,
  });

  @override
  State<CreateActivityForm> createState() => _CreateActivityFormState();
}

class _CreateActivityFormState extends State<CreateActivityForm> {
  List<DateTime?> _selectedDateRange = [];

  void _showDateRangePicker(BuildContext context) async {
    final List<DateTime?>? dates =
        await DateRangeDialogHelper.showDateRangePicker(
          context: context,
          initialDates: _selectedDateRange,
        );

    final canNotEmptyDate =
        dates != null &&
        dates.length == 2 &&
        dates[0] != null &&
        dates[1] != null;

    if (canNotEmptyDate) {
      final DateTime startDate = dates[0]!;
      final DateTime endDate = dates[1]!;

      final formattedStartDate = DateFormatter.formatDate(startDate);
      final formattedEndDate = DateFormatter.formatDate(endDate);
      final dateRangeString = '$formattedStartDate - $formattedEndDate';

      setState(() {
        _selectedDateRange = dates;
        widget.dateRangeController.text = dateRangeString;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: widget.nameController,
          keyboardType: TextInputType.name,
          preffIconPath: 'assets/icons/task.png',
          hintText: 'Nom de l\'activite',
        ),

        const SizedBox(height: 12.0),

        InkWell(
          onTap: () => _showDateRangePicker(context),
          child: IgnorePointer(
            child: CustomTextFieldReadOnly(
              controller: widget.dateRangeController,
              keyboardType: TextInputType.text,
              preffIconPath: 'assets/icons/calendar.png',
              hintText: 'Date de début - Date de fin',
              readOnly: true,
            ),
          ),
        ),

        const SizedBox(height: 12.0),

        CustomTextField(
          controller: widget.locationController,
          keyboardType: TextInputType.name,
          preffIconPath: 'assets/icons/localisation.png',
          hintText: 'Lieu de l\'activite',
        ),
      ],
    );
  }
}
