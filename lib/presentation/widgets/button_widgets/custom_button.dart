// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customButton({
  required Color color,
  required String title,
  required Color textColor,
  required VoidCallback? onSubmit,
}) {
  return SizedBox(
    height: 50.0,
    width: 230.0,
    child: ElevatedButton(
      onPressed: onSubmit,
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(
        title,
        style: GoogleFonts.robotoCondensed(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget imageButton() {
  return Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/icons/google.png', height: 24),
        const SizedBox(width: 10),
        Text(
          "Continue avec Google",
          style: GoogleFonts.robotoCondensed(fontSize: 16, color: Colors.black),
        ),
      ],
    ),
  );
}
