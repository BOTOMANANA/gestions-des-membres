import 'package:association_appli/presentation/pages/home_page.dart';
import 'package:association_appli/presentation/pages/introduction_page.dart';
import 'package:association_appli/presentation/pages/members/create_member_page.dart';
import 'package:association_appli/presentation/pages/members/novices_members_page.dart';
import 'package:association_appli/presentation/pages/members/seniors_members_page.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const String introductionPage = '/introduction';
  static const String home = '/home';
  static const String novice = '/novice';
  static const String senior = '/senior';
  static const String helder = '/helder';
  static const String moreMembers = '/more';
  static const String createMember = '/create';

  static Map<String, WidgetBuilder> routes = {
    introductionPage: (context) => IntroductionPage(),
    home: (context) => HomePage(),
    novice: (context) => NovicesMembersPage(),
    senior: (context) => SeniorsMembersPage(),
    createMember: (context) => CreateMemberPage(),
  };
}
