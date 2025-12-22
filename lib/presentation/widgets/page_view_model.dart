import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageViewModel extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  const PageViewModel({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 240),
        const SizedBox(height: 60),
        _buildPageTitle(title: title),
        const SizedBox(height: 20),
        _buildPageDescription(description: description),
        const SizedBox(height: 60),
      ],
    );
  }

  Padding _buildPageTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: FittedBox(
        child: Text(
          title,
          style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Padding _buildPageDescription({required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: GoogleFonts.robotoCondensed(
          fontSize: 16,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
