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

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProviders>(
      builder: (context, provider, child) {
        return TextField(
          controller: _userInputController,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Recherche...',
            hintStyle: AppFonts.robotoCondensedFont(
              size: 12.0,
              color: Colors.black,
            ),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/', width: 16, height: 16),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: LightThemeColors.textFieldBorderColors,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: LightThemeColors.colorPrimary),
            ),
          ),
          onChanged: (value) {
            _searchMember(providers: provider);
          },
        );
      },
    );
  }

  void _searchMember({required MemberProviders providers}) {
    final fullName = _userInputController.text.trim();
    if (fullName.isNotEmpty) {
      providers.searchSingleMember(fullName: fullName);
    }
  }
}
