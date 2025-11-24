import 'package:association_appli/presentation/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';

class BuildIntialEmptyStatePlaceholder extends StatelessWidget {
  final String? title;
  final String image;
  final String message;

  const BuildIntialEmptyStatePlaceholder({
    super.key,
    this.title,
    required this.image,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100.0),
        EmptyStateWidget(title: title!, imageEmpty: image, message: message),
      ],
    );
  }
}
