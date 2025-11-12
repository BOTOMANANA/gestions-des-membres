import 'package:association_appli/presentation/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';

class EmptyActivityInPage extends StatelessWidget {
  final String imageEmpty;
  final String title;
  final String description;
  const EmptyActivityInPage({
    super.key,
    required this.imageEmpty,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 80.0),
          EmptyStateWidget(
            title: title,
            imageEmpty: imageEmpty,
            message: description,
          ),
        ],
      ),
    );
  }
}
