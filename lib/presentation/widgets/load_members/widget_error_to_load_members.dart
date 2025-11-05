import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/providers/single_member_provider.dart';
import 'package:flutter/material.dart';

Widget widgetErrorToLoadMembers({required MemberProviders provider}) {
  return Center(child: Text(provider.errorMessage));
}

Widget widgetErrorToLoadSingleMember({required SingleMemberProvider provider}) {
  return Center(child: Text(provider.errorMessage));
}
