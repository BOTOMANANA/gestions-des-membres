// ignore_for_file: file_names
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String preffIconPath;
  final String? suffIconPath;
  final String hintText;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.preffIconPath,
    this.suffIconPath,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      cursorColor: LightThemeColors.colorPrimary,
      cursorRadius: Radius.circular(4.0),
      cursorOpacityAnimates: true,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.robotoCondensed(
          color: LightThemeColors.textFieldBorderColors,
          fontSize: 14.0,
        ),

        hoverColor: Colors.blue,
        prefixIcon: _customIcon(iconPath: widget.preffIconPath),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                  icon: _suffixIcon(isVisible: _obscureText),
                )
                : (widget.suffIconPath != null
                    ? _customIcon(iconPath: widget.suffIconPath!)
                    : null),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 16.0,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: LightThemeColors.textFieldBorderColors),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: LightThemeColors.textFieldBorderColors),
        ),
      ),
    );
  }
}

Widget _customIcon({required String iconPath}) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Image.asset(iconPath, width: 16.0, height: 16.0),
  );
}

Widget _suffixIcon({required bool isVisible}) {
  return Image.asset(
    isVisible ? 'assets/icons/eyeslash.png' : 'assets/icons/eye.png',
    width: 16.0,
    height: 16.0,
  );
}
