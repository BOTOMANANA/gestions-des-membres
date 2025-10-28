// ignore_for_file: unused_element

import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthBottomSheet extends StatefulWidget {
  final bool isLoginStart;
  const AuthBottomSheet({super.key, required this.isLoginStart});

  @override
  State<AuthBottomSheet> createState() => _AuthBottomSheetState();
}

class _AuthBottomSheetState extends State<AuthBottomSheet> {
  late bool isLogin;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    isLogin = widget.isLoginStart;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.7,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              _designHeaderBar,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _designAuthTab(
                    title: "Créer un compte",
                    isSelected: !isLogin,
                    onTap: () => setState(() => isLogin = false),
                  ),
                  const SizedBox(width: 50),
                  _designAuthTab(
                    title: "Se connecter",
                    isSelected: isLogin,
                    onTap: () => setState(() => isLogin = true),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: AnimatedSwitcher(
                    duration: const Duration(microseconds: 300),
                    transitionBuilder:
                        (child, animation) =>
                            FadeTransition(opacity: animation, child: child),
                    child:
                        isLogin
                            ? AuthForm(isLogin: true)
                            : AuthForm(isLogin: false),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _designHeaderBar = Padding(
  padding: EdgeInsets.only(top: 10, bottom: 20),
  child: Container(
    width: 60,
    height: 4,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);

Widget _designAuthTab({
  required String title,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? LightThemeColors.colorPrimary : Colors.black45,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: 4,
          width: isSelected ? 90 : 0,
          decoration: BoxDecoration(
            color: LightThemeColors.colorPrimary,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    ),
  );
}

Widget _indacatorText({required String title}) {
  return Text(
    title,
    style: GoogleFonts.robotoCondensed(
      fontSize: 12,
      color: LightThemeColors.textFieldBorderColors,
    ),
  );
}
