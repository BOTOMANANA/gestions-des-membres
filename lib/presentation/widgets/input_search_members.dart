// ignore_for_file: override_on_non_overriding_member

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputSearchMembers extends StatefulWidget {
  final String category;
  const InputSearchMembers({super.key, required this.category});

  @override
  State<InputSearchMembers> createState() => _InputSearchMembersState();
}

class _InputSearchMembersState extends State<InputSearchMembers> {
  final _userInputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Écoute le changement de texte pour reconstruire l'icône de suffixe (croix/loupe)
    _userInputController.addListener(_updateSuffixIcon);
  }

  @override
  void dispose() {
    _userInputController.removeListener(_updateSuffixIcon);
    _userInputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // Fonction pour forcer la reconstruction du widget (et de l'icône)
  void _updateSuffixIcon() {
    setState(() {});
  }

  // Fonction de recherche centralisée
  void _performSearch(MemberProviders providers, String value) {
    final fullName = value.trim();
    if (fullName.isNotEmpty) {
      // Déclenche la recherche filtrée par catégorie
      providers.searchMember(fullName: fullName, category: widget.category);
    } else if (fullName.isEmpty) {
      // Si le champ est vide, on efface les résultats de recherche pour afficher la liste complète
      providers.getMembersByStatus(category: widget.category);
    } else {
      providers.clearSearchResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProviders>(
      builder: (context, provider, child) {
        // Variable pour vérifier si du texte est entré
        final hasText = _userInputController.text.isNotEmpty;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 48.0,
            child: TextField(
              focusNode: _focusNode,
              controller: _userInputController,
              keyboardType: TextInputType.name,

              // Déclenche la recherche à chaque frappe
              onChanged: (value) {
                _performSearch(provider, value);
              },

              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Recherche...',
                hintStyle: AppFonts.robotoCondensedFont(
                  size: 14.0,
                  color: LightThemeColors.textFieldBorderColors,
                ),

                suffixIcon:
                    provider.isSearching
                        ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            width: 14.0,
                            height: 14.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: LightThemeColors.colorPrimary,
                            ),
                          ),
                        )
                        : IconButton(
                          onPressed: () {
                            // Si du texte est présent, on efface et on vide les résultats
                            if (hasText) {
                              _userInputController.clear();
                              provider.clearSearchResult();
                              provider.getMembersByStatus(
                                category: widget.category,
                              );
                            }
                            FocusScope.of(context).unfocus();
                          },
                          icon: Image.asset(
                            hasText
                                ? 'assets/icons/close.png'
                                : 'assets/icons/search.png',
                            width: 18.0,
                            height: 18.0,
                          ),
                        ),

                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 16.0,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: LightThemeColors.textFieldBorderColors,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: LightThemeColors.colorPrimary),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
