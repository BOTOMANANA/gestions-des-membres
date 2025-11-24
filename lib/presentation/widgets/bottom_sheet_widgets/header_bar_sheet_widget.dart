import 'package:flutter/material.dart';

class HeaderBarSheetWidget extends StatelessWidget {
  const HeaderBarSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 20),
      child: Container(
        width: 60,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
