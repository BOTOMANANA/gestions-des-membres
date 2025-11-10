// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final String imageEmpty;
  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    required this.imageEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            // shadow bottom right
            color: LightThemeColors.colorPrimary.withOpacity(0.5),
            offset: Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 1,
          ),

          BoxShadow(
            // shadow top Left
            color: LightThemeColors.textBlack,
            offset: Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: _body(title: title, message: message, image: imageEmpty),
    );
  }

  Widget _body({
    required String title,
    required String message,
    required String image,
  }) {
    return Column(
      children: [
        Image.asset('assets/icons/call.png'),
        Text(title),
        Text(message),
      ],
    );
  }
}
