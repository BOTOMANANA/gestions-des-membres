// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:association_appli/domain/entities/user_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/pages/home_page.dart';
import 'package:association_appli/presentation/providers/user_providers.dart';
import 'package:association_appli/presentation/widgets/button/custom_button.dart';
import 'package:association_appli/presentation/widgets/button/custom_image_button.dart';
import 'package:association_appli/presentation/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  final bool isLogin;
  const AuthForm({super.key, required this.isLogin});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _clearController() {
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  void _onSubmit(
    BuildContext context, {
    required UserProviders providers,
  }) async {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty ||
        password.isEmpty ||
        (!widget.isLogin && fullName.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champ")),
      );
    }

    if (widget.isLogin) {
      final success = await providers.loginUser(
        email: email,
        password: password,
      );
      if (success) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
        _clearController();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email ou mot de passe incorrect")),
        );
      }

      return;
    }
    final user = UserEntity(name: fullName, email: email, password: password);
    providers.signupUser(userEntity: user);
    _clearController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProviders>(
      builder: (context, userProvider, _) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextFieldSection(),
              const SizedBox(height: 40.0),
              _buildActionSection(provider: userProvider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextFieldSection() {
    return Column(
      children: [
        if (!widget.isLogin) ...[
          SizedBox(height: 4.0),
          _buildFielLabel(label: 'Nom et prénom'),
          SizedBox(height: 4.0),

          CustomTextField(
            controller: fullNameController,
            keyboardType: TextInputType.name,
            preffIconPath: 'assets/icons/profilegrey.png',
            hintText: 'Nom complet',
          ),
        ],
        if (widget.isLogin) ...[
          SizedBox(height: 20.0),
          Center(child: Text('Connecter sur AntMobile!')),
        ],

        SizedBox(height: 12.0),
        _buildFielLabel(label: 'Adress mail'),
        SizedBox(height: 4.0),

        CustomTextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          preffIconPath: 'assets/icons/envelope.png',
          hintText: 'E-mail',
        ),

        const SizedBox(height: 12.0),
        _buildFielLabel(label: 'Mot de passe'),
        const SizedBox(height: 4.0),
        CustomTextField(
          controller: passwordController,
          keyboardType: TextInputType.number,
          preffIconPath: 'assets/icons/lock.png',
          hintText: 'Mot de passe',
          isPassword: true,
        ),
      ],
    );
  }

  Widget _buildActionSection({required UserProviders provider}) {
    return Center(
      child: Column(
        children: [
          customButton(
            color: LightThemeColors.colorPrimary,
            title: 'Enregistrer',
            textColor: Colors.white,
            onSubmit: () => _onSubmit(context, providers: provider),
          ),
          const SizedBox(height: 8.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0),
            child: Divider(
              height: 1.0,
              thickness: 1.0,
              color: LightThemeColors.textFieldBorderColors,
            ),
          ),

          const SizedBox(height: 8.0),
          customImageButton(
            background: LightThemeColors.colorPrimary.withOpacity(0.08),
            iconPath: 'assets/icons/email.png',
            title: 'Continuer avec google',
            tileColor: Colors.black,
            onTap: null,
          ),
        ],
      ),
    );
  }

  TextStyle get labelStyle => GoogleFonts.robotoCondensed(
    fontSize: 12.0,
    color: LightThemeColors.textFieldBorderColors,
  );

  Widget _buildFielLabel({required String label}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: AppFonts.robotoCondensedFont(
          size: 12.0,
          color: LightThemeColors.textFieldBorderColors,
        ),
      ),
    );
  }
}
