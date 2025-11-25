import 'package:association_appli/domain/entities/product_entity.dart';
import 'package:association_appli/presentation/colors/Light_theme_colors.dart';
import 'package:association_appli/presentation/fonts/app_fonts.dart';
import 'package:association_appli/presentation/providers/product_provider.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_button_cancel.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_text_buttom.dart';
import 'package:association_appli/presentation/widgets/customTextField.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowCreateProductDialog extends StatefulWidget {
  final int activityId;
  const ShowCreateProductDialog({super.key, required this.activityId});

  @override
  State<ShowCreateProductDialog> createState() =>
      _ShowCreateProductDialogState();
}

class _ShowCreateProductDialogState extends State<ShowCreateProductDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _requiredTicketController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _requiredTicketController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final name = _nameController.text;
    final price = _priceController.text.toDouble();
    final requiredTickets = _requiredTicketController.text.toInt();

    final isNotValid =
        _nameController.text.isEmpty &&
        _priceController.text.isEmpty &&
        _requiredTicketController.text.isEmpty;
    if (isNotValid) {
      print("create product invalid check form");
    }
    final product = ProductEntity(
      activityId: widget.activityId,
      name: name,
      price: price,
      requiredTickets: requiredTickets,
      createAt: DateTime.now(),
    );
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.createProduct(product: product);
    print("==============>>>>>>>>>>>> product created with successfully");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 24.0,
      ),
      content: SizedBox(
        height: 340.0,
        width: 400.0,
        child: Form(key: _formKey, child: _buildContentOfDialog()),
      ),
    );
  }

  Widget _buildContentOfDialog() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: customButtonCancelWithSize(context: context, size: 30.0),
        ),
        _buildTextFieldSection(),
      ],
    );
  }

  Widget _buildTextFieldSection() {
    return Column(
      children: [
        SizedBox(height: 28.0),
        Text(
          'Creer un produit',
          style: AppFonts.robotoFont(
            size: 18.0,
            color: LightThemeColors.textSemiBlack,
            weight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.0),
        CustomTextField(
          controller: _nameController,
          keyboardType: TextInputType.name,
          preffIconPath: 'assets/icons/task.png',
          hintText: 'Nom du produit',
        ),

        const SizedBox(height: 12.0),

        CustomTextField(
          controller: _priceController,
          keyboardType: TextInputType.number,
          preffIconPath: 'assets/icons/localisation.png',
          hintText: 'Prix par membre',
        ),

        const SizedBox(height: 12.0),

        CustomTextField(
          controller: _requiredTicketController,
          keyboardType: TextInputType.number,
          preffIconPath: 'assets/icons/localisation.png',
          hintText: 'Ticket obligatoire',
        ),

        const SizedBox(height: 24.0),

        CustomTextButtom(
          background: LightThemeColors.colorPrimary,
          title: 'Enregistrer',
          color: Colors.white,
          width: 220.0,
          onPressed: () => _onSubmit(),
        ),
      ],
    );
  }
}
