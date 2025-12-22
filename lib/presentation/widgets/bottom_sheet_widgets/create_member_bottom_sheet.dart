// ignore_for_file: deprecated_member_use

import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/show_responsible_dialog.dart';
import 'package:association_appli/presentation/widgets/bottom_sheet_widgets/header_bar_sheet_widget.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_text_buttom.dart';
import 'package:association_appli/presentation/widgets/custom_text_field.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateMemberBottomSheet extends StatefulWidget {
  final String status;
  const CreateMemberBottomSheet({super.key, required this.status});

  @override
  State<CreateMemberBottomSheet> createState() =>
      _CreateMemberBottomSheetState();
}

class _CreateMemberBottomSheetState extends State<CreateMemberBottomSheet> {
  final _fullNameController = TextEditingController();
  final _genreController = TextEditingController();
  final _countryController = TextEditingController();
  final _cinController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _quarterController = TextEditingController();
  final _facultyController = TextEditingController();
  final _studentCardNumberController = TextEditingController();
  final _freeShipController = TextEditingController();
  final _responsibleController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _genreController.dispose();
    _countryController.dispose();
    _cinController.dispose();
    _phoneNumberController.dispose();
    _quarterController.dispose();
    _facultyController.dispose();
    _studentCardNumberController.dispose();
    _freeShipController.dispose();
    _responsibleController.dispose();
    super.dispose();
  }

  void _selectResponsible() async {
    final String? selectedResponsible = await ShowResponsibleDialog.showDialog(
      context: context,
    );

    if (selectedResponsible != null) {
      if (mounted) {
        _responsibleController.text = selectedResponsible;
        // print('================>>>>>>>> $selectedResponsible');
      }
    }
  }

  void _onSubmit() {
    final fullName = _fullNameController.text.toString();
    final genre = _genreController.text;
    final country = _countryController.text.trim();
    final cin = _cinController.text.toInt();
    final phoneNumber = _phoneNumberController.text.toInt();
    final quarter = _quarterController.text.trim();
    final faculty = _facultyController.text.trim();
    final studentCardNumber = _studentCardNumberController.text.toString();
    final responsible = _responsibleController.text.trim();
    final freeShip = _freeShipController.text.toInt();
    // print('=============== $responsible ================');

    final insertMember = MemberEntity(
      fullName: fullName,
      genre: genre,
      country: country,
      cinNumber: cin,
      phoneNumber: phoneNumber,
      faculty: faculty,
      quarter: quarter,
      studentCardNumber: studentCardNumber,
      category: widget.status,
      memberResponsability: responsible,
      memberShipFee: freeShip,
      createAt: DateTime.now(),
    );
    context.read<MemberProviders>().createMember(memberEntity: insertMember);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return _buildContentBottomSheet();
      },
    );
  }

  Widget _buildContentBottomSheet() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeaderBarSheetWidget(),
            const SizedBox(height: 50.0),
            _buildHeaderTextFieldSection(),
            _buildGridTextFieldSection(),
            const SizedBox(height: 20.0),
            CustomTextButtom(
              background: LightThemeColors.colorPrimary,
              title: 'Enregistre',
              color: Colors.white,
              width: 200.0,
              onPressed: () => _onSubmit(),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderTextFieldSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          CustomTextField(
            controller: _fullNameController,
            keyboardType: TextInputType.name,
            preffIconPath: 'assets/icons/profilegrey.png',
            hintText: 'Nom et prenom',
          ),

          const SizedBox(height: 20.0),

          CustomTextField(
            controller: _countryController,
            keyboardType: TextInputType.name,
            preffIconPath: 'assets/icons/city.png',
            hintText: 'district',
          ),

          const SizedBox(height: 4.0),
        ],
      ),
    );
  }

  Widget _buildGridTextFieldSection() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 14.0,
      childAspectRatio: 2.8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      children: [
        CustomTextField(
          controller: _cinController,
          keyboardType: TextInputType.number,
          preffIconPath: 'assets/icons/drapeauuu.png',
          hintText: 'CNI',
        ),

        CustomTextField(
          controller: _phoneNumberController,
          keyboardType: TextInputType.number,
          preffIconPath: 'assets/icons/call.png',
          hintText: 'Telephone',
        ),
        CustomTextField(
          controller: _facultyController,
          keyboardType: TextInputType.text,
          preffIconPath: 'assets/icons/teacher.png',
          hintText: 'Parcours',
        ),
        CustomTextField(
          controller: _studentCardNumberController,
          keyboardType: TextInputType.text,
          preffIconPath: 'assets/icons/personalcard.png',
          hintText: 'Numero CE',
        ),
        CustomTextField(
          controller: _quarterController,
          keyboardType: TextInputType.text,
          preffIconPath: 'assets/icons/city.png',
          hintText: 'Quartier',
        ),
        CustomTextField(
          controller: _freeShipController,
          keyboardType: TextInputType.number,
          preffIconPath: 'assets/icons/wallet.png',
          hintText: 'Adhesion',
        ),

        InkWell(
          onTap: _selectResponsible,
          child: IgnorePointer(
            child: CustomTextFieldReadOnly(
              controller: _responsibleController,
              keyboardType: TextInputType.text,
              preffIconPath: 'assets/icons/wallet.png',
              hintText: 'Responsabilite',
              readOnly: true,
            ),
          ),
        ),

        CustomTextField(
          controller: _genreController,
          keyboardType: TextInputType.name,
          preffIconPath: 'assets/icons/city.png',
          hintText: 'Genre',
        ),
      ],
    );
  }
}
