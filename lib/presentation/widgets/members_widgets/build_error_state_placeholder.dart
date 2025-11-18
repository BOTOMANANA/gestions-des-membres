import 'package:flutter/material.dart';

Widget buildErrorStatePlaceholder({required String errorMessage}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        errorMessage,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}
