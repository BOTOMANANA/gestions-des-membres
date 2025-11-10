import 'package:flutter/material.dart';

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
