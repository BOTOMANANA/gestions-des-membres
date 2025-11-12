import 'package:association_appli/presentation/widgets/empty_state_widget.dart';
import 'package:association_appli/presentation/widgets/input_search_members.dart';
import 'package:flutter/material.dart';

Widget emptyResultForSearchingMember({
  required String title,
  required String status,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: InputSearchMembers(category: 'Doyen'),
      ),
      SizedBox(height: 80.0),
      EmptyStateWidget(
        title: title,
        imageEmpty: 'assets/images/document.png',
        message:
            'Aucun membre $status ne correspond  \n à votre recherche. Je suis desole!',
      ),
    ],
  );
}

Widget emptyResultAndElderMemberNotFound({required String status}) {
  return Center(child: Text('Aucun $status trouvé dans la base de donnee'));
}
