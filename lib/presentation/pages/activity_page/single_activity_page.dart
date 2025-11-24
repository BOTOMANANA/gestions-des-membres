import 'package:flutter/material.dart';

class SingleActivityPage extends StatelessWidget {
  final int id;
  const SingleActivityPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Listes de fonctionnalite qu\'il faut implementer'),
    );
  }
}
