// ignore_for_file: prefer_final_field
import 'package:association_appli/presentation/widgets/members_rounded_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';

class HomePageOne extends StatefulWidget {
  const HomePageOne({super.key});

  @override
  State<HomePageOne> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePageOne> {
  final PageController controller = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Column(children: [MembersRoundedStatusWidget()])),
    Center(child: Text('Search Page')),
    Center(child: Text('Profile Page')),
    Center(child: Text('settings Page')),
    Center(child: Text('other Page')),
  ];
  final List<Widget> _titles = [
    Text('Homepage'),
    Text('Searchpage'),
    Text('profilepage'),
    Text('settingsPage'),
    Text('OtherPage'),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: _titles[_currentIndex],
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomBarLabelSlide(
        selectedIndex: _currentIndex,
        color: Colors.blue,
        backgroundColor: Colors.white,

        items: [
          BottomBarItem(iconData: Icons.home, label: 'Home'),
          BottomBarItem(iconData: Icons.message_rounded, label: 'Message'),
          BottomBarItem(iconData: Icons.notifications, label: 'Notifications'),
          BottomBarItem(iconData: Icons.calendar_month, label: 'Calendrier'),
          BottomBarItem(iconData: Icons.settings, label: 'Parametres'),
        ],
        onSelect: (index) {
          setState(() {
            _currentIndex = index;
          });
          // implement your select function here
        },
      ),
    );
  }
}
