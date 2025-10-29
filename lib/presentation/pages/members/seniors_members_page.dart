import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/member_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeniorsMembersPage extends StatelessWidget {
  const SeniorsMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<MemberProviders>(
        builder: (context, provider, child) {
          if (provider.state == MemberState.loading) {
            return _loadingMembers();
          }

          if (provider.state == MemberState.error) {
            return _errorWidget(provider: provider);
          }

          if (provider.state == MemberState.succes) {
            return _listAllSeniorMembers(provider: provider);
          }
          return Center();
        },
      ),
    );
  }

  Widget _loadingMembers() {
    return Center(
      child: CircularProgressIndicator(color: LightThemeColors.colorPrimary),
    );
  }

  Widget _errorWidget({required MemberProviders provider}) {
    return Center(child: Text(provider.errorMessage));
  }

  Widget _listAllSeniorMembers({required MemberProviders provider}) {
    return ListView.builder(
      itemCount: provider.members.length,
      itemBuilder: (context, index) {
        return MemberItemWidget(memberEntity: provider.members[index]);
      },
    );
  }
}
