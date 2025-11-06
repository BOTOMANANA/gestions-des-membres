import 'package:flutter/material.dart';

class ShowSnackbarMessage extends StatefulWidget {
  final String message;
  final String indicatorText;
  const ShowSnackbarMessage({
    super.key,
    required this.message,
    required this.indicatorText,
  });

  @override
  State<ShowSnackbarMessage> createState() => _ShowSnackbarMessageState();
}

class _ShowSnackbarMessageState extends State<ShowSnackbarMessage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: SnackBar(
        content: Text(
          '${widget.message} '
          ' ${widget.indicatorText}',
        ),
      ),
    );
  }
}
