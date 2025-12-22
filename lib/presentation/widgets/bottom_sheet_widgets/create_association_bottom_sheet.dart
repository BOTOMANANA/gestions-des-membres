// ignore_for_file: avoid_print

import 'package:association_appli/domain/entities/association_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/providers/association_provider.dart';
import 'package:association_appli/presentation/widgets/bottom_sheet_widgets/header_bar_sheet_widget.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_text_buttom.dart';
import 'package:association_appli/presentation/widgets/custom_text_field.dart';
import 'package:association_appli/presentation/widgets/text_field/build_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAssociationBottomSheet extends StatefulWidget {
  const CreateAssociationBottomSheet({super.key});

  @override
  State<CreateAssociationBottomSheet> createState() =>
      _CreateAssociationBottomSheetState();
}

class _CreateAssociationBottomSheetState
    extends State<CreateAssociationBottomSheet> {
  final nameController = TextEditingController();
  final siegeController = TextEditingController();
  final sloganController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    siegeController.dispose();
    sloganController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    bool canNotValid =
        nameController.text.isEmpty &&
        siegeController.text.isEmpty &&
        sloganController.text.isEmpty;

    if (canNotValid) {
      print('is not valid formular');
    }
    final name = nameController.text;
    final siege = siegeController.text;
    final slogan = sloganController.text;
    final provider = Provider.of<AssociationProvider>(context, listen: false);
    final association = AssociationEntity(
      name: name,
      siege: siege,
      slogan: slogan,
    );
    provider.createAssociation(associationEntity: association);
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
      child: SingleChildScrollView(child: _buildFormWidget()),
    );
  }

  Widget _buildFormWidget() {
    return Column(
      children: [
        HeaderBarSheetWidget(),
        const SizedBox(height: 50.0),
        _buildTextField(
          controller: nameController,
          label: "Nom d'association",
          hintText: "Nom de votre association",
          prefIcon: 'assets/icons/mail.png',
        ),
        _buildTextField(
          controller: siegeController,
          label: "Siege",
          hintText: "Siege de votre association",
          prefIcon: 'assets/icons/mail.png',
        ),
        _buildTextField(
          controller: sloganController,
          label: "Slogan",
          hintText: "slogan de votre association",
          prefIcon: 'assets/icons/mail.png',
        ),
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
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required String prefIcon,
  }) {
    return Column(
      children: [
        const SizedBox(height: 12.0),
        BuildLabelWidget(label: label),
        const SizedBox(height: 4.0),
        CustomTextField(
          controller: controller,
          keyboardType: TextInputType.text,
          preffIconPath: prefIcon,
          hintText: hintText,
        ),
      ],
    );
  }
}
