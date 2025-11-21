import 'package:association_appli/domain/entities/activity_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/providers/activity_provider.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/date_range_dialog_helper.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_button_cancel.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_text_buttom.dart';
import 'package:association_appli/presentation/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  List<DateTime?> _selectedDateRange = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _dateRangeController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  void _showDateRangePicker(BuildContext context) async {
    final List<DateTime?>? dates =
        await DateRangeDialogHelper.showDateRangePicker(
          context: context,
          initialDates: _selectedDateRange,
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
        _selectedDateRange = dates;
        _dateRangeController.text = dateRangeString;
      });
    }
  }

  _onSubmit() {
    if (_nameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _selectedDateRange.length < 2) {
      print('Veuillez remplir tous les champs ');
      return;
    }
    final name = _nameController.text;
    final location = _locationController.text;
    final DateTime formattedStartDate = _selectedDateRange[0]!;
    final DateTime formattedEndDate = _selectedDateRange[1]!;

    final newActivityEntity = ActivityEntity(
      name: name,
      startDate: formattedStartDate,
      endDate: formattedEndDate,
      location: location,
    );
    final activityProvider = Provider.of<ActivityProvider>(
      context,
      listen: false,
    );
    activityProvider.createActivity(activity: newActivityEntity);
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
        child: Form(key: _formKey, child: _buildContentOfDialog()),
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
        SizedBox(height: 28.0),
        Text(
          'Lancer une activiter',
          style: AppFonts.robotoFont(
            size: 18.0,
            color: LightThemeColors.textSemiBlack,
            weight: FontWeight.bold,
          ),
        ),
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
          controller: _locationController,
          keyboardType: TextInputType.name,
          preffIconPath: 'assets/icons/localisation.png',
          hintText: 'Lieu de l\'activite',
        ),

        const SizedBox(height: 24.0),

        CustomTextButtom(
          background: LightThemeColors.colorPrimary,
          title: 'Enregistrer',
          color: Colors.white,
          width: 220.0,
          onPressed: () => _onSubmit(),
        ),
      ],
    );
  }
}
