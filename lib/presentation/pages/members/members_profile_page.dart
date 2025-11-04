import 'package:association_appli/presentation/providers/single_member_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MembersProfilePage extends StatelessWidget {
  final int id;
  const MembersProfilePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // Récupère le provider global sans le recréer
    final provider = Provider.of<SingleMemberProvider>(context, listen: false);

    // Appelle getMemberById après la première frame pour éviter d'appeler notifyListeners dans build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getMemberById(id: id);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: const [
          Row(
            children: [
              Icon(Icons.call),
              SizedBox(width: 8),
              Icon(Icons.qr_code),
              SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: Consumer<SingleMemberProvider>(
        builder: (context, provider, _) {
          if (provider.state == SingleMemberState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.state == SingleMemberState.error) {
            return Center(child: Text(provider.errorMessage));
          }

          if (provider.state == SingleMemberState.succes) {
            final member = provider.memberEntity!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cardProfile(
                    fullName: member.fullName,
                    country: member.country,
                  ),
                  const SizedBox(height: 20),
                  Text('CIN: ${member.cinNumber}'),
                  Text('Faculty: ${member.faculty}'),
                  Text('Category: ${member.category ?? 'N/A'}'),
                  Text(
                    'Responsibility: ${member.memberResponsability ?? 'N/A'}',
                  ),
                  Text('Quarter: ${member.quarter}'),
                  const SizedBox(height: 20),
                  _cotisationList(
                    freeShip: member.memberShipFee.toInt(),
                    social: 0, // à adapter si tu as les valeurs
                    amountActivity: 0, // idem
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  // Exemple de carte profile simplifiée
  Stack _cardProfile({required String fullName, required String country}) {
    return Stack(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(country, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Cotisation exemple
  Row _cotisationList({
    required int freeShip,
    required int social,
    required int amountActivity,
  }) {
    final text = ['Adhesion', 'C.Socials', 'Activites'];
    final amounts = [freeShip, social, amountActivity];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(text.length, (index) {
        return Column(
          children: [
            Text(
              '${amounts[index]}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(text[index]),
          ],
        );
      }),
    );
  }
}
