import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/member_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listes des membres'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: Consumer<MemberProviders>(
        builder: (context, provider, _) {
          if (provider.state == MemberState.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.state == MemberState.error) {
            return Center(child: Text(provider.errorMessage));
          }

          if (provider.state == MemberState.succes) {
            return ListView.builder(
              itemCount: provider.members.length,
              itemBuilder: (context, index) {
                return MemberItemWidget(memberEntity: provider.members[index]);
              },
            );
          }
          return Center();
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
