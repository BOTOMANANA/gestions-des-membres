import 'package:flutter/material.dart';

Widget customIconButton({
  required String iconPath,
  required VoidCallback onPressed,
}) {
  return IconButton(
    onPressed: onPressed,
    icon: Image.asset(iconPath, width: 16.0, height: 16.0),
  );
}
