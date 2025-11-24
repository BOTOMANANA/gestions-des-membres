import 'package:association_appli/presentation/widgets/empty_activity_in_page.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EmptyActivityInPage(
          imageEmpty: 'assets/images/statistics.png',
          title: 'Pas d acitivite',
          description:
              'Commencez votre premier activite depuis maintainent! Creez-en une et passez a laction',
        ),
      ),
    );
  }
}
