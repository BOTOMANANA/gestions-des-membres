import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customImageButton({
  required Color background,
  required String iconPath,
  required String title,
  required Color tileColor,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 220.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(iconPath, width: 24, height: 24),
            ),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: tileColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
