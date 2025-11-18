import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

snackBarWidget({
  required BuildContext context,
  required String title,
  String? details,
  required ContentType type,
}) {
  final snackbar = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: SizedBox(
      height: 64.0,
      child: AwesomeSnackbarContent(
        title: title,
        message: "$details \n \n",
        contentType: type,
        inMaterialBanner: true,
        titleTextStyle: TextStyle(fontSize: 14.0),
        messageTextStyle: TextStyle(fontSize: 12.0),
      ),
    ),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackbar);
}
