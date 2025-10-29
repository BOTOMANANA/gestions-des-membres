import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:flutter/material.dart';

Widget widgetErrorToLoadMembers({required MemberProviders provider}) {
  return Center(child: Text(provider.errorMessage));
}
