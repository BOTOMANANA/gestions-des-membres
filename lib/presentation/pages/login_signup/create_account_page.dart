// ignore_for_file: deprecated_member_use

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/widgets/auth_bottom_sheet.dart';
import 'package:association_appli/presentation/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/listen.png', height: 200),

        const SizedBox(height: 70),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: FittedBox(
            child: const Text(
              'Bienvenue sur AntMobile !',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Avant dutilise AntMobile Service\n sil vous plait, sincrire dabord',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
        const SizedBox(height: 60.0),

        customButton(
          color: LightThemeColors.colorPrimary,
          title: 'Creer un compte',
          textColor: Colors.white,
          onSubmit: () => _showBottomSheet(context: context, isLogin: false),
        ),
        const SizedBox(height: 10),

        customButton(
          color: LightThemeColors.colorPrimary.withOpacity(0.12),
          title: 'Se connecter',
          textColor: LightThemeColors.colorPrimary,
          onSubmit: () => _showBottomSheet(context: context, isLogin: true),
        ),
        const SizedBox(height: 20),
        _textCondition,
      ],
    ),
  );
}

Widget _textCondition = const Padding(
  padding: EdgeInsets.symmetric(horizontal: 16),
  child: Text(
    "Pour continuer, veuillez confirmer que vous avez lu et accepte \n les conditions dutilisation de lapplication. Cela nous permet \n de garantir une meilleure experience pour tous nos utlisateurs.",
    style: TextStyle(
      color: Colors.black87,
      fontSize: 10,
      fontWeight: FontWeight.w300,
    ),
  ),
);

Future _showBottomSheet({
  required BuildContext context,
  required bool isLogin,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AuthBottomSheet(isLoginStart: isLogin),
  );
}
