// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Padding createDateTimeAt({required DateTime createAt, required Color color}) {
  final formatedDate = DateFormat('yyyy-MM-dd').format(createAt);
  return Padding(
    padding: const EdgeInsets.only(bottom: 24.0),
    child: Text(formatedDate, style: TextStyle(color: color, fontSize: 10)),
  );
}
