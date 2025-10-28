import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle robotoCondensedFont({
    required size,
    required Color color,
    FontWeight? weight,
  }) {
    return GoogleFonts.robotoCondensed(
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }

  static TextStyle robotoFont({
    required size,
    required Color color,
    FontWeight? weight,
  }) {
    return GoogleFonts.roboto(fontSize: size, color: color, fontWeight: weight);
  }
}
