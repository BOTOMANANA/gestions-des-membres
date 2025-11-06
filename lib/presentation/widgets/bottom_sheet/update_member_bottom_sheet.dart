import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/widgets/auth_bottom_sheet.dart';
import 'package:association_appli/presentation/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class UpdateMemberBottomSheet extends StatefulWidget {
  final MemberEntity memberEntity;
  const UpdateMemberBottomSheet({super.key, required this.memberEntity});

  @override
  State<UpdateMemberBottomSheet> createState() =>
      _UpdateMemberBottomSheetState();
}

class _UpdateMemberBottomSheetState extends State<UpdateMemberBottomSheet> {

  final _fullNameController = TextEditingController();
  final _countryController = TextEditingController();
  final _cinController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _quarterController = TextEditingController();
  final _facultyController = TextEditingController();
  final _studentCardNumberController = TextEditingController();
  final _freeShipController = TextEditingController();
  _
  void _onSubmit() {}

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
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
    return SingleChildScrollView(child: Column(children: []));
  }

  Widget _headerTextFieldSection() {
    return Column(
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
    );
  }

  Widget _bodyGridTextFieldSection(){
return  GridView.count(
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
       
      ],
    );
  }
}
