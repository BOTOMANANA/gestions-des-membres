// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/providers/association_provider.dart';
import 'package:association_appli/presentation/routes/page_routes.dart';
import 'package:association_appli/presentation/widgets/bottom_sheet_widgets/create_association_bottom_sheet.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAssociationPage extends StatefulWidget {
  const CreateAssociationPage({super.key});

  @override
  State<CreateAssociationPage> createState() => _CreateAssociationPageState();
}

class _CreateAssociationPageState extends State<CreateAssociationPage> {
  bool hasAssociation = false;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AssociationProvider>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: _buildPageContent(context),
    );
  }

  Widget _buildPageContent(BuildContext context) {
    return Consumer<AssociationProvider>(
      builder: (context, provider, _) {
        bool hasAssociation = provider.state == AssociationState.loaded;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeaderSection(),
              const SizedBox(height: 60.0),

              AbsorbPointer(
                absorbing: hasAssociation, // empêche les clics
                child: Opacity(
                  opacity: hasAssociation ? 0.4 : 1.0, // effet visuel gris
                  child: customButton(
                    color: LightThemeColors.colorPrimary,
                    title: 'Créer une association',
                    textColor: Colors.white,
                    onSubmit: () => CreateAssociationBottomSheet(),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),

              customButton(
                color: LightThemeColors.colorPrimary.withOpacity(0.12),
                title: 'Suivant',
                textColor: LightThemeColors.colorPrimary,
                onSubmit: () => Navigator.pushNamed(context, PageRoutes.home),
              ),
              const SizedBox(height: 20.0),
              _buildUsageTermsNote(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        Image.asset('assets/images/listen.png', height: 200.0),
        const SizedBox(height: 70.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FittedBox(
            child: _buildStyledText(
              text: 'Bienvenue sur AntMobile !',
              color: LightThemeColors.textBlack,
              size: 24.0,
              weight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: _buildStyledText(
            text:
                'Avant dutilise AntMobile Service\n sil vous plait, sincrire dabord',
            color: LightThemeColors.textSemiBlack,
            size: 16.0,
          ),
        ),
      ],
    );
  }

  Text _buildStyledText({
    required String text,
    required Color color,
    required double size,
    FontWeight? weight,
  }) {
    return Text(
      text,
      style: AppFonts.robotoCondensedFont(
        size: size,
        color: color,
        weight: weight,
      ),
    );
  }

  Widget _buildUsageTermsNote() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: _buildStyledText(
        text:
            "Pour continuer, veuillez confirmer que vous avez lu et accepte \n les conditions dutilisation de lapplication. Cela nous permet \n de garantir une meilleure experience pour tous nos utlisateurs.",
        color: LightThemeColors.textSemiBlack,
        size: 10.0,
        weight: FontWeight.w300,
      ),
    );
  }
}
