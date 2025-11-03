import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class TextFieldDesgin extends StatefulWidget {
  final TextEditingController controller;
  final String prefIcon;
  final String hintText;
  final String? preffHintText;

  const TextFieldDesgin({
    super.key,
    required this.controller,
    required this.prefIcon,
    required this.hintText,
    this.preffHintText,
  });

  @override
  State<TextFieldDesgin> createState() => _TextFieldDesginState();
}

class _TextFieldDesginState extends State<TextFieldDesgin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: LightThemeColors.textFieldBorderColors),
      ),
      child: Row(
        children: [
          Image.asset(widget.prefIcon, width: 24, height: 24),
          SizedBox(width: 1.0),
          Text(widget.preffHintText ?? ''),
          SizedBox(width: 1.0),
          VerticalDivider(
            width: 1.0,
            color: LightThemeColors.textFieldBorderColors,
          ),
          SizedBox(width: 2.0),
          _textFieldSection(),
        ],
      ),
    );
  }

  Widget _textFieldSection() {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        hintStyle: AppFonts.robotoCondensedFont(
          size: 14,
          color: LightThemeColors.textFieldBorderColors,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
      ),
    );
  }
}
