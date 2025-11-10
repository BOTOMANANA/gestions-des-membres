// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:flutter/material.dart';

class CarousselWidget extends StatelessWidget {
  const CarousselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Container(
            height: 180.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: LightThemeColors.colorPrimary,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          Positioned(
            right: 211,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(34.0),
              ),
              child: Image.asset(
                'assets/images/backgroundcard.png',
                height: 189.0,
                color: Colors.white.withOpacity(0.4),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
