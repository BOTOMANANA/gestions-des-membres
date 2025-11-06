import 'package:flutter/material.dart';

Widget createDateTimeAt({required String createAt, required Color color}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 24.0),
    child: Text(
      createAt.toString(),
      style: TextStyle(color: color, fontSize: 10),
    ),
  );
}
