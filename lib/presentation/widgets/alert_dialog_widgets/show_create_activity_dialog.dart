import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/date_range_dialog_helper.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_button_cancel.dart';
import 'package:association_appli/presentation/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class ShowCreateActivityDialog extends StatefulWidget {
  const ShowCreateActivityDialog({super.key});

  @override
  State<ShowCreateActivityDialog> createState() =>
      _ShowCreateActivityDialogState();
}

class _ShowCreateActivityDialogState extends State<ShowCreateActivityDialog> {
  final _nameController = TextEditingController();
  final _dateRangeController = TextEditingController();
  final _locationController = TextEditingController();
  List<DateTime?> selectedPeriod = [];

  @override
  void dispose() {
    _nameController.dispose();
    _dateRangeController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  void _showDateRangePicker(BuildContext context) async {
    final List<DateTime?>? dates =
        await DateRangeDialogHelper.showDateRangePicker(
          context: context,
          initialDates: selectedPeriod,
        );

    if (dates != null &&
        dates.length == 2 &&
        dates[0] != null &&
        dates[1] != null) {
      final DateTime startDate = dates[0]!;
      final DateTime endDate = dates[1]!;

      final String formattedStartDate = _formatDate(startDate);
      final String formattedEndDate = _formatDate(endDate);
      final String dateRangeString = '$formattedStartDate - $formattedEndDate';

      setState(() {
        selectedPeriod = dates;
        _dateRangeController.text = dateRangeString;
      });
    }
  }

  _onSubmit() {
    final name = _nameController.text;
    final date = _dateRangeController.text;
    final location = _locationController.text;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 24.0,
      ),
      content: SizedBox(
        height: 340.0,
        width: 400.0,
        child: _buildContentOfDialog(),
      ),
    );
  }

  Widget _buildContentOfDialog() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: customButtonCancelWithSize(context: context, size: 30.0),
        ),
        _buildTextFieldSection(),
      ],
    );
  }

  Widget _buildTextFieldSection() {
    return Column(
      children: [
        SizedBox(height: 32.0),
        Text('Lancer une activiter'),
        SizedBox(height: 20.0),
        CustomTextField(
          controller: _nameController,
          keyboardType: TextInputType.name,
          preffIconPath: 'assets/icons/task.png',
          hintText: 'Nom de l\'activite',
        ),

        const SizedBox(height: 12.0),

        InkWell(
          onTap: () => _showDateRangePicker(context),
          child: IgnorePointer(
            child: CustomTextFieldReadOnly(
              controller: _dateRangeController,
              keyboardType: TextInputType.text,
              preffIconPath: 'assets/icons/calendar.png',
              hintText: 'Date de début - Date de fin',
              readOnly: true,
            ),
          ),
        ),
        const SizedBox(height: 12.0),

        CustomTextField(
          controller: _nameController,
          keyboardType: TextInputType.name,
          preffIconPath: 'assets/icons/localisation.png',
          hintText: 'Lieu de l\'activite',
        ),

        const SizedBox(height: 24.0),
        _customTextButton(
          onPressed: () {
            _onSubmit();
          },
          title: 'Enregistrer',
          backgroundColor: LightThemeColors.colorPrimary,
          textColor: Colors.white,
        ),
      ],
    );
  }

  Widget _customTextButton({
    required VoidCallback onPressed,
    required String title,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return SizedBox(
      width: 220.0,
      height: 48.0,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(
          title,
          style: AppFonts.robotoCondensedFont(size: 14.0, color: textColor),
        ),
      ),
    );
  }
}
