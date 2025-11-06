// ignore_for_file: override_on_non_overriding_member

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputSearchMembers extends StatefulWidget {
  const InputSearchMembers({super.key});

  @override
  State<InputSearchMembers> createState() => _InputSearchMembersState();
}

class _InputSearchMembersState extends State<InputSearchMembers> {
  final _userInputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _userInputController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProviders>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SizedBox(
              height: 48.0,
              child: TextField(
                focusNode: _focusNode,
                controller: _userInputController,
                keyboardType: TextInputType.name,
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
                              child:
                                  _userInputController.text.isNotEmpty
                                      ? CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: LightThemeColors.colorPrimary,
                                      )
                                      : const SizedBox(),
                            ),
                          )
                          : IconButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              _onSearchChanged(providers: provider);
                            },
                            icon: Image.asset(
                              'assets/icons/search.png',
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
                    borderSide: BorderSide(
                      color: LightThemeColors.colorPrimary,
                    ),
                  ),
                ),
                onChanged: (value) {
                  _onSearchChanged(providers: provider);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _onSearchChanged({required MemberProviders providers}) {
    final fullName = _userInputController.text.trim();
    (fullName.isNotEmpty)
        ? providers.searchSingleMember(fullName: fullName)
        : providers.clearSearchResult();
  }
}
