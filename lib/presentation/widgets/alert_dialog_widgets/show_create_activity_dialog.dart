import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
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
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _localisationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _localisationController.dispose();
    super.dispose();
  }

  _onSubmit() {
    final name = _nameController.text.toString();
    final startDate = _startDateController.text.toString();
    final endDate = _endDateController.text.toString();
    final localisation = _localisationController.text.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(height: 320.0, child: _buildContentOfDialog()),
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
        Column(
          children: [
            SizedBox(height: 32.0),
            Text('Lancer une activiter'),
            SizedBox(height: 20.0),
            CustomTextField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              preffIconPath: 'assets/icons/calendar.png',
              hintText: 'Nom de l\'activite',
            ),

            SizedBox(height: 8.0),
            CustomTextField(
              controller: _startDateController,
              keyboardType: TextInputType.datetime,
              preffIconPath: 'assets/icons/calendar.png',
              hintText: 'Date de debut',
            ),
            SizedBox(height: 8.0),

            CustomTextField(
              controller: _endDateController,
              keyboardType: TextInputType.datetime,
              preffIconPath: 'assets/icons/city.png',
              hintText: 'Date de fin',
            ),
            SizedBox(height: 16.0),
            _customTextButton(
              onPressed: () {
                _onSubmit();
              },
              title: 'Enregistrer',
              backgroundColor: LightThemeColors.colorPrimary,
              textColor: Colors.white,
            ),
          ],
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
