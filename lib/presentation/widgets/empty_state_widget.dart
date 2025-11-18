// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatefulWidget {
  final String title;
  final String imageEmpty;
  final String message;
  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.imageEmpty,
    required this.message,
  });

  @override
  State<EmptyStateWidget> createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<EmptyStateWidget> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.white;
    Offset distance = Offset(4.0, 4.0);
    double blur = 30.0;
    return Center(
      child: Column(
        children: [
          Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(24.0),
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: LightThemeColors.textFieldBorderColors.withOpacity(
                    0.5,
                  ),
                  offset: distance,
                  blurRadius: blur,
                  spreadRadius: 1,
                ),

                BoxShadow(
                  color: LightThemeColors.colorPrimary.withOpacity(0.12),
                  offset: -distance,
                  blurRadius: blur,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: _body(title: widget.title, image: widget.imageEmpty),
          ),
          Center(child: _showEmptyMessage(message: widget.message)),
        ],
      ),
    );
  }

  Widget _body({required String title, required String image}) {
    return Column(
      children: [
        SizedBox(height: 8.0),
        Image.asset(image, width: 100, height: 100),
        SizedBox(height: 4.0),
        _textStyle(data: title, size: 13.0, weight: FontWeight.w600),
      ],
    );
  }
}

Widget _textStyle({
  required String data,
  required double size,
  FontWeight? weight,
}) {
  return Text(
    data,
    style: AppFonts.robotoCondensedFont(
      size: size,
      color: LightThemeColors.textSemiBlack,
      weight: weight,
    ),
  );
}

Widget _showEmptyMessage({required String message}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        textAlign: TextAlign.center,
        message,
        style: AppFonts.robotoCondensedFont(
          size: 16.0,
          color: LightThemeColors.textSemiBlack,
        ),
      ),
    ),
  );
}
