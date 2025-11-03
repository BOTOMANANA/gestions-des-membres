import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/button/custom_button.dart';
import 'package:association_appli/presentation/widgets/customTextField.dart';
import 'package:association_appli/presentation/widgets/dropdown_and_ratio/dropdown_items_responsability.dart';
import 'package:association_appli/presentation/widgets/dropdown_and_ratio/genre_radio_widget.dart';
import 'package:association_appli/presentation/widgets/text_field/text_field_desgin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateMemberPage extends StatefulWidget {
  const CreateMemberPage({super.key});

  @override
  State<CreateMemberPage> createState() => _CreateMemberPageState();
}

List<String> genre = ['Homme', 'Femme'];

class _CreateMemberPageState extends State<CreateMemberPage> {
  final _fullNameController = TextEditingController();
  final _countryController = TextEditingController();
  final _cinController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _quarterController = TextEditingController();
  final _facultyController = TextEditingController();
  final _studentCardNumberController = TextEditingController();
  final _statusController = TextEditingController();
  final _responsabilityController = TextEditingController();
  final _freeShipController = TextEditingController();

  final _genreController = TextEditingController();

  String? _selected;
  final List<Map> responsabilityOption = [
    {
      'id': '1',
      'imagePath': 'assets/icons/basketball.png',
      'name': 'Basketball',
    },
    {'id': '2', 'imagePath': 'assets/icons/football.png', 'name': 'Foot-ball'},
    {'id': '3', 'imagePath': 'assets/icons/quiz.png', 'name': 'Quiz'},
    {'id': '4', 'imagePath': 'assets/icons/materials.png', 'name': 'Materiels'},
    {'id': '5', 'imagePath': 'assets/icons/danse.png', 'name': 'Danse'},
  ];

  String currentGenre = genre[0];

  void clearTextFieldController() {
    _fullNameController.dispose();
    _countryController.dispose();
    _cinController.dispose();
    _phoneNumberController.dispose();
    _quarterController.dispose();
    _facultyController.dispose();
    _studentCardNumberController.dispose();
    _statusController.dispose();
    _responsabilityController.dispose();
    _freeShipController.dispose();

    _genreController.dispose();
  }

  void appendMemberToDatabase({required MemberProviders provider}) {
    // final fullName = _fullNameController.text.toString();
    // final country = _countryController.text.trim();
    // final cin = _cinController.text.toString();
    // final phoneNumber = _phoneNumberController.text.toString();
    // final quarter = _quarterController.text.toString();
    // final faculty = _facultyController.text.toString();
    // final studentCardNumber = _studentCardNumberController.text.toString();
    // final memberStatus = _statusController.text.toString();
  }

  @override
  void dispose() {
    clearTextFieldController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ajout membre"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Consumer<MemberProviders>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.0),
                _createTextFieldSection(),
                _dropdownWidget(),
                SizedBox(height: 10.0),
                radioWidget(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _createTextFieldSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          CustomTextField(
            controller: _fullNameController,
            keyboardType: TextInputType.name,
            preffIconPath: 'assets/icons/basketball.png',
            hintText: 'Nom et prenom',
          ),

          const SizedBox(height: 20.0),

          CustomTextField(
            controller: _countryController,
            keyboardType: TextInputType.name,
            preffIconPath: 'assets/icons/football.png',
            hintText: 'district',
          ),

          const SizedBox(height: 20.0),

          CustomTextField(
            controller: _cinController,
            keyboardType: TextInputType.name,
            preffIconPath: 'assets/icons/danse.png',
            hintText: 'cin',
          ),

          const SizedBox(height: 20.0),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.8,
              padding: const EdgeInsets.all(16),
              children: [
                TextFieldDesgin(
                  controller: _phoneNumberController,
                  prefIcon: 'assets/icons/quiz.png',
                  hintText: 'Téléphone',
                  preffHintText: 'Tel',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdownWidget() {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: LightThemeColors.textFieldBorderColors,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),

      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            isExpanded: true,
            borderRadius: BorderRadius.circular(12),
            dropdownColor: Colors.white,
            icon: Icon(Icons.arrow_drop_down_circle_outlined),
            value: _selected,
            hint: const Text('Responsabilite'),
            onChanged: (responsability) {
              setState(() {
                _selected = responsability!;
              });
            },
            items: dropdownItemsResponsability(),
          ),
        ),
      ),
    );
  }

  Widget radioWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _designRadioButton(genreOption: genre[0]),
        const SizedBox(width: 40.0),
        _designRadioButton(genreOption: genre[1]),
      ],
    );
  }

  Widget _designRadioButton({required String genreOption}) {
    final bool isSelected = currentGenre == genreOption;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentGenre = genreOption;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 50.0,
        width: 140,
        decoration: BoxDecoration(
          color:
              isSelected ? LightThemeColors.colorPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: genreOption,
              groupValue: currentGenre,
              activeColor: LightThemeColors.colorPrimary,
              onChanged: (value) {
                setState(() {
                  currentGenre = value!;
                });
              },
            ),
            textGenreOption(option: genreOption, canSelected: isSelected),
          ],
        ),
      ),
    );
  }
}
