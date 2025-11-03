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
      height: 20.0,
      width: 200.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: LightThemeColors.textFieldBorderColors),
      ),
      child: Row(
        children: [
          Image.asset(widget.prefIcon, width: 24.0, height: 24.0),
          SizedBox(width: 1.0),
          Text(widget.preffHintText ?? ''),
          SizedBox(width: 2.0),
          SizedBox(
            height: 30.0,
            child: VerticalDivider(
              width: 1.0,
              thickness: 1.0,
              color: LightThemeColors.textFieldBorderColors,
            ),
          ),
          Expanded(child: _textFieldSection()),
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
          size: 14.0,
          color: LightThemeColors.textFieldBorderColors,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 16.0,
        ),
      ),
    );
  }
}
