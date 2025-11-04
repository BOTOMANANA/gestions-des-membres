// ignore_for_file: use_key_in_widget_constructors, unused_element

import 'package:association_appli/core/di/get_it.dart';
import 'package:association_appli/presentation/providers/single_member_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MembersProfilePage extends StatelessWidget {
  final int id;
  const MembersProfilePage({required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            Row(children: [Icon(Icons.call), Icon(Icons.qr_code)]),
          ],
        ),

        body: Consumer<SingleMemberProvider>(
          builder: (context, provider, _) {
            if (provider.state == SingleMemberState.loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (provider.state == SingleMemberState.error) {
              return Center(child: Text(provider.errorMessage));
            }
            if (provider.state == SingleMemberState.succes) {
              return Center(
                child: Column(
                  children: [
                    Text(provider.memberEntity!.fullName),
                    Text(provider.memberEntity!.country),
                    Text('${provider.memberEntity!.cinNumber}'),
                    Text(provider.memberEntity!.faculty),
                    Text(provider.memberEntity!.category!),
                    Text(provider.memberEntity!.memberResponsability!),
                    Text(provider.memberEntity!.quarter),
                  ],
                ),
              );
            }
            return Center();
          },
        ),
      ),
      create: (context) => getIt<SingleMemberProvider>()..getMemberById(id: id),
    );
  }
}

Stack _cardProfile({required String fullName, required String country}) {
  return Stack(
    children: [
      Container(
        height: 200.0,
        width: 200.0,
        color: Colors.blue,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      ),
      Image.asset('name'),
      Center(
        child: Column(
          children: [
            Row(children: [Text(fullName), Text(country)]),
            SizedBox(height: 20.0),
            Row(children: [
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Row _cotisationList({
  required int freeShip,
  required int social,
  required int amountActivity,
}) {
  List<String> text = ['Adhesion', 'C.Socials', 'Activites'];
  List<int> amount = [freeShip, social, amountActivity];

  return Row(
    children: [
      ListView.builder(
        itemCount: text.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(amount[index] as String), Text(text[index])],
          );
        },
      ),
      // Column(children: [Text('$freeShip'), Text('Adhesion')]),
      // Column(children: [Text('$social'), Text('C.Socials')]),
      // Column(children: [Text('$amountActivity'), Text('Activites')]),
    ],
  );
}
