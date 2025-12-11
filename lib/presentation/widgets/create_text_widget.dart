import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:flutter/widgets.dart';

class CreateTextWidget {
  static Text buildTextWidget({
    required String data,
    required Color color,
    required double size,
    required FontWeight weight,
  }) {
    return Text(
      data,
      style: AppFonts.robotoFont(size: size, color: color, weight: weight),
      overflow: TextOverflow.ellipsis,
    );
  }
}
