// ignore_for_file: deprecated_member_use

import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/auth_bottom_sheet.dart';
import 'package:association_appli/presentation/widgets/customTextField.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateMemberBottomSheet extends StatefulWidget {
  final MemberEntity memberEntity;
  const UpdateMemberBottomSheet({super.key, required this.memberEntity});

  @override
  State<UpdateMemberBottomSheet> createState() =>
      _UpdateMemberBottomSheetState();
}

class _UpdateMemberBottomSheetState extends State<UpdateMemberBottomSheet> {
  final _fullNameController = TextEditingController();
  final _genreController = TextEditingController();
  final _countryController = TextEditingController();
  final _cinController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _quarterController = TextEditingController();
  final _facultyController = TextEditingController();
  final _studentCardNumberController = TextEditingController();
  final _freeShipController = TextEditingController();
  final _categoryController = TextEditingController();
  final _responsabilityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final member = widget.memberEntity;
    _fullNameController.text = member.fullName;
    _genreController.text = member.genre;
    _countryController.text = member.country;
    _cinController.text = member.cinNumber.toString();
    _phoneNumberController.text = member.phoneNumber.toString();
    _quarterController.text = member.quarter;
    _facultyController.text = member.faculty;
    _studentCardNumberController.text = member.studentCardNumber;
    _freeShipController.text = member.memberShipFee.toString();
    _categoryController.text = member.category ?? '';
    _responsabilityController.text = member.memberResponsability ?? '';
  }

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
    _categoryController.dispose();
    _responsabilityController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final memberId = widget.memberEntity.id!;
    final fullName = _fullNameController.text.toString();
    final genre = _genreController.text;
    final country = _countryController.text.trim();
    final cin = _cinController.text.toInt();
    final phoneNumber = _phoneNumberController.text.toInt();
    final quarter = _quarterController.text.trim();
    final faculty = _facultyController.text.trim();
    final studentCardNumber = _studentCardNumberController.text.toString();
    final category = _categoryController.text.trim();
    final responsability = _responsabilityController.text.trim();
    final freeShip = _freeShipController.text.toInt();

    final updateMember = MemberEntity(
      id: memberId,
      fullName: fullName,
      genre: genre,
      country: country,
      cinNumber: cin,
      phoneNumber: phoneNumber,
      faculty: faculty,
      quarter: quarter,
      studentCardNumber: studentCardNumber,
      category: category,
      memberResponsability: responsability,
      memberShipFee: freeShip,
      createAt: DateTime.now(),
    );
    context.read<MemberProviders>().updateMember(memberEntity: updateMember);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return _createContentBottomSheet();
      },
    );
  }

  Widget _createContentBottomSheet() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: _bodyOfBottomSheet(),
    );
  }

  Widget _bodyOfBottomSheet() {
    return Column(children: [designHeaderBar, _createBottomSheetFormular()]);
  }

  Widget _createBottomSheetFormular() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 12.0),
          _headerTextFieldSection(),
          _gridTextFieldSection(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: CustomTextField(
              controller: _genreController,
              keyboardType: TextInputType.name,
              preffIconPath: 'assets/icons/city.png',
              hintText: 'Genre',
            ),
          ),
          SizedBox(height: 20.0),
          _footerButtonSelction(),
        ],
      ),
    );
  }

  Widget _headerTextFieldSection() {
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

          SizedBox(height: 4.0),
        ],
      ),
    );
  }

  Widget _gridTextFieldSection() {
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
        CustomTextField(
          controller: _categoryController,
          keyboardType: TextInputType.text,
          preffIconPath: 'assets/icons/city.png',
          hintText: 'Category',
        ),
        CustomTextField(
          controller: _responsabilityController,
          keyboardType: TextInputType.number,
          preffIconPath: 'assets/icons/wallet.png',
          hintText: 'Responsabilite',
        ),
      ],
    );
  }

  Widget _footerButtonSelction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _customTextButton(
          onPressed: () => Navigator.pop(context),
          title: 'Annuler',
          backgroundColor: LightThemeColors.colorPrimary.withOpacity(0.1),
          textColor: LightThemeColors.colorPrimary,
          width: 100,
        ),
        SizedBox(width: 12.0),
        _customTextButton(
          onPressed: () => _onSubmit(),
          title: 'Sauvegarder',
          backgroundColor: LightThemeColors.colorPrimary,
          textColor: Colors.white,
          width: 200,
        ),
      ],
    );
  }

  Widget _customTextButton({
    required VoidCallback onPressed,
    required String title,
    required Color backgroundColor,
    required Color textColor,
    required double width,
  }) {
    return SizedBox(
      width: width,
      height: 48.0,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
        child: _childTextButton(title: title, color: textColor),
      ),
    );
  }

  Text _childTextButton({required String title, required Color color}) {
    return Text(
      title,
      style: AppFonts.robotoCondensedFont(
        size: 16.0,
        color: color,
        weight: FontWeight.w500,
      ),
    );
  }
}
