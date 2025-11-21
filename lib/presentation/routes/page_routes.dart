import 'package:association_appli/presentation/pages/home_page.dart';
import 'package:association_appli/presentation/pages/introduction_page.dart';
import 'package:association_appli/presentation/pages/main_navigation_page.dart';
import 'package:association_appli/presentation/pages/member_page/all_members_page.dart';
import 'package:association_appli/presentation/pages/member_page/create_member_page.dart';
import 'package:association_appli/presentation/pages/member_page/elder_members_page.dart';
import 'package:association_appli/presentation/pages/member_page/novices_members_page.dart';
import 'package:association_appli/presentation/pages/member_page/office_members_page.dart';
import 'package:association_appli/presentation/pages/member_page/seniors_members_page.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const String introductionPage = '/introduction';
  static const String mainNavigationBar = '/mainNavBar';
  static const String home = '/home';
  static const String novice = '/novice';
  static const String senior = '/senior';
  static const String older = '/older';
  static const String allMembers = '/allMembers';
  static const String officeMembers = '/officeMembers';
  static const String moreMembers = '/more';
  static const String createMember = '/create';

  static Map<String, WidgetBuilder> routes = {
    introductionPage: (context) => IntroductionPage(),
    mainNavigationBar: (context) => MainNavigationPage(),
    home: (context) => HomePage(),
    novice: (context) => NovicesMembersPage(),
    senior: (context) => SeniorsMembersPage(),
    older: (context) => ElderMembersPage(),
    allMembers: (context) => AllMembersPage(),
    officeMembers: (context) => OfficeMembersPage(),
    createMember: (context) => CreateMemberPage(),
  };
}
