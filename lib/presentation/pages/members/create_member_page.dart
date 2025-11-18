import 'package:association_appli/domain/entities/member_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/providers/member_providers.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/snack_bar_widget.dart';
import 'package:association_appli/presentation/widgets/button/custom_button.dart';
import 'package:association_appli/presentation/widgets/customTextField.dart';
import 'package:association_appli/presentation/widgets/custom_appbar_widget.dart';
import 'package:association_appli/presentation/widgets/dropdown_and_ratio/dropdown_items_responsability.dart';
import 'package:association_appli/presentation/widgets/dropdown_and_ratio/genre_radio_widget.dart';
import 'package:association_appli/presentation/widgets/dropdown_and_ratio/member_category_item.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
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
  final _freeShipController = TextEditingController();

  String? _selectedResponsability;
  String? _selectedCategory;
  String currentGenre = genre[0];

  void appendMemberToDatabase({required MemberProviders provider}) {
    final fullName = _fullNameController.text.toString();
    final country = _countryController.text.trim();
    final cin = _cinController.text.toString();
    final phoneNumber = _phoneNumberController.text.toString();
    final quarter = _quarterController.text.toString();
    final faculty = _facultyController.text.toString();
    final studentCardNumber = _studentCardNumberController.text.toString();
    final freeShip = _freeShipController.text.toDouble();

    MemberEntity member = MemberEntity(
      fullName: fullName,
      genre: currentGenre,
      country: country,
      cinNumber: cin.toInt(),
      phoneNumber: phoneNumber.toInt(),
      faculty: faculty,
      quarter: quarter,
      studentCardNumber: studentCardNumber,
      category: _selectedCategory,
      memberResponsability: _selectedResponsability,
      memberShipFee: freeShip.toInt(),
      createAt: DateTime.now(),
    );

    provider.createMember(memberEntity: member);
    snackBarWidget(
      context: context,
      title: 'Felicitaions $fullName',
      details: 'Vous etes membre maintenant',
      type: ContentType.success,
    );
    context.read<MemberProviders>().reasetState();
    FocusScope.of(context).unfocus();

    clearTextFieldController();
    renderDropdownInitial();
  }

  void renderDropdownInitial() {
    setState(() {
      _selectedCategory = null;
      _selectedResponsability = null;
    });
  }

  void clearTextFieldController() {
    _fullNameController.clear();
    _countryController.clear();
    _cinController.clear();
    _phoneNumberController.clear();
    _quarterController.clear();
    _facultyController.clear();
    _studentCardNumberController.clear();
    _freeShipController.clear();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _countryController.dispose();
    _cinController.dispose();
    _phoneNumberController.dispose();
    _quarterController.dispose();
    _facultyController.dispose();
    _studentCardNumberController.dispose();
    _freeShipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWidget(
        context: context,
        title: 'Ajout de membre',
        background: Colors.white,
        icon: 'assets/icons/arrowleftt.png',
      ),
      backgroundColor: Colors.white,
      body: Consumer<MemberProviders>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.0),
                _headerTextFieldSection(),
                _gridViewForm(),
                SizedBox(height: 8.0),
                radioWidget(),
                SizedBox(height: 40.0),
                customButton(
                  color: LightThemeColors.colorPrimary,
                  title: 'Enregistre',
                  textColor: Colors.white,
                  onSubmit: () => appendMemberToDatabase(provider: provider),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _headerTextFieldSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
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

  Widget _gridViewForm() {
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
        _dropdownMemberCategoryWidget(),

        _dropdownResponsabilityWidget(),
      ],
    );
  }

  Widget _dropdownResponsabilityWidget() {
    return Container(
      width: 200.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: LightThemeColors.textFieldBorderColors,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),

      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: SizedBox(
            height: 40.0,
            child: DropdownButton<String>(
              isExpanded: true,
              borderRadius: BorderRadius.circular(12.0),
              dropdownColor: Colors.white,
              icon: Image.asset('assets/icons/angledown.png'),
              value: _selectedResponsability,
              hint: const Text('Responsabilite'),
              onChanged: (responsability) {
                setState(() {
                  _selectedResponsability = responsability!;
                });
              },
              items: memberItemsResponsability(
                selected: _selectedResponsability,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dropdownMemberCategoryWidget() {
    return Container(
      width: 200.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: LightThemeColors.textFieldBorderColors,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),

      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: SizedBox(
            height: 40.0,
            child: DropdownButton<String>(
              isExpanded: true,
              borderRadius: BorderRadius.circular(12.0),
              dropdownColor: Colors.white,
              icon: Image.asset('assets/icons/angledown.png'),
              value: _selectedCategory,
              hint: const Text('Categorie'),
              onChanged: (responsability) {
                setState(() {
                  _selectedCategory = responsability!;
                });
              },
              items: memberCategoryItem(selected: _selectedCategory),
            ),
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
        width: 140.0,
        decoration: BoxDecoration(
          color:
              isSelected ? LightThemeColors.colorPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Transform.scale(
              scale: isSelected ? 1.2 : 1.0,
              child: Radio<String>(
                value: genreOption,
                groupValue: currentGenre,
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    currentGenre = value!;
                  });
                },
              ),
            ),
            genreChoiceText(option: genreOption, canSelected: isSelected),
          ],
        ),
      ),
    );
  }
}
