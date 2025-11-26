import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:flutter/material.dart';

class SingleActivitieDetailsPage extends StatefulWidget {
  const SingleActivitieDetailsPage({super.key});

  @override
  State<SingleActivitieDetailsPage> createState() =>
      _SingleActivitieDetailsPageState();
}

class _SingleActivitieDetailsPageState
    extends State<SingleActivitieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 100.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Row(
                children: [
                  Column(
                    children: [
                      Text('Details de l\'activite'),
                      Text('Bonjour antonio'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverAppBar(
            expandedHeight: 200.0,
            backgroundColor: LightThemeColors.colorPrimary,
            flexibleSpace: FlexibleSpaceBar(
              background: Row(),
              title: Text('data'),
            ),
          ),
        ],
      ),
    );
  }
}
