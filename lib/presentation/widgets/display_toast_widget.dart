import 'package:flutter/material.dart';

class DisplayToastWidget extends StatelessWidget {
  final String message;
  final String? description;
  const DisplayToastWidget({
    super.key,
    required this.message,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
