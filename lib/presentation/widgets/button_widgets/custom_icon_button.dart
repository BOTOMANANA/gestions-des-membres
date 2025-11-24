import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final Color backgroundColor;
  final VoidCallback onPressed;
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(icon),
      label: const Text('Réessayer'),
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: backgroundColor,
      ),
    );
  }
}

Widget customIconButton({
  required String iconPath,
  required double size,
  required VoidCallback onPressed,
}) {
  return IconButton(
    onPressed: onPressed,
    icon: Image.asset(iconPath, width: size, height: size),
  );
}
