import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomTextButtom extends StatelessWidget {
  final Color background;
  final String title;
  final Color color;
  final double width;
  final VoidCallback onPressed;

  const CustomTextButtom({
    super.key,
    required this.background,
    required this.title,
    required this.color,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48.0,
      child: TextButton(
        onPressed: onPressed,
        style: _buildStyle(),
        child: _buildChild(title: title, color: color),
      ),
    );
  }

  ButtonStyle _buildStyle() {
    return TextButton.styleFrom(
      backgroundColor: background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
    );
  }

  Text _buildChild({required String title, required Color color}) {
    return Text(
      title,
      style: AppFonts.robotoCondensedFont(
        size: 16.0,
        color: color,
        weight: FontWeight.w500,
      ),
    );
  }
}
