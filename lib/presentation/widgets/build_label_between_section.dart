import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/widgets/create_text_widget.dart';
import 'package:flutter/material.dart';

class BuildLabelBetweenSection extends StatelessWidget {
  final String leftLabel;
  final String? rightLabel;
  final Color leftLabelColor;
  final Color? rightLabelColor;
  final VoidCallback? onPressed;
  const BuildLabelBetweenSection({
    super.key,
    required this.leftLabel,
    required this.leftLabelColor,
    this.rightLabel,
    this.rightLabelColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CreateTextWidget.buildTextWidget(
          data: leftLabel,
          color: leftLabelColor,
          size: 16.0,
          weight: FontWeight.w600,
        ),
        _buildTextButton(text: rightLabel, color: rightLabelColor),
      ],
    );
  }

  TextButton _buildTextButton({required String? text, required Color? color}) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        textStyle: AppFonts.robotoCondensedFont(size: 12.0, color: color!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(text!),
          SizedBox(width: 4.0),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 12.0,
            color: text.isEmpty ? Colors.white : color,
          ),
        ],
      ),
    );
  }
}
