import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateMemberPage extends StatefulWidget {
  const CreateMemberPage({super.key});

  @override
  State<CreateMemberPage> createState() => _CreateMemberPageState();
}

class _CreateMemberPageState extends State<CreateMemberPage> {
  final _fullNameController = TextEditingController();
  final _countryController = TextEditingController();
  final _cinController = TextEditingController();
  final _responsabilityController = TextEditingController();
  final _facultyController = TextEditingController();
  final _nbrCardStudentController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _freeShipController = TextEditingController();

  void clearTextFieldController() {
    _fullNameController.dispose();
    _cinController.dispose();
    _facultyController.dispose();
    _phoneNumberController.dispose();
    _freeShipController.dispose();
    _nbrCardStudentController.dispose();
  }

  void appendMemberToDatabase({required MemberProviders provider}) {
    final fullName = _fullNameController.text.trim();
    final country = _countryController.text.trim();
    final cin = _cinController.text.trim();
  }

  @override
  void dispose() {
    clearTextFieldController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberProviders>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(title: Text("ajout membre"), centerTitle: true),
          body: SingleChildScrollView(
            child: Column(children: [_createTextFieldSection()]),
          ),
        );
      },
    );
  }

  Widget _createTextFieldSection() {
    return Column(
      children: [
        CustomTextField(
          controller: _fullNameController,
          keyboardType: TextInputType.name,
          preffIconPath: '',
          hintText: 'Nom et prenom',
        ),

        const SizedBox(height: 20.0),

        CustomTextField(
          controller: _countryController,
          keyboardType: TextInputType.name,
          preffIconPath: '',
          hintText: 'district',
        ),

        const SizedBox(height: 20.0),

        CustomTextField(
          controller: _cinController,
          keyboardType: TextInputType.name,
          preffIconPath: '',
          hintText: 'cin',
        ),

        const SizedBox(height: 20.0),
      ],
    );
  }
}
