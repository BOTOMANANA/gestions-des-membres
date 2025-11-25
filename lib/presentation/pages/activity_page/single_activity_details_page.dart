import 'package:association_appli/domain/entities/product_entity.dart';
import 'package:association_appli/presentation/providers/product_provider.dart';
import 'package:association_appli/presentation/utils/number_formatter.dart';
import 'package:association_appli/presentation/widgets/alert_dialog_widgets/show_create_product_dialog.dart';
import 'package:association_appli/presentation/widgets/button_widgets/custom_text_buttom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleActivityDetailsPage extends StatefulWidget {
  final int id;

  const SingleActivityDetailsPage({super.key, required this.id});

  @override
  State<SingleActivityDetailsPage> createState() =>
      _SingleActivityDetailsState();
}

class _SingleActivityDetailsState extends State<SingleActivityDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(
        context,
        listen: false,
      ).fetchProducts(activityId: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de l\'Activité'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Activité ID: ${widget.id}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            CustomTextButtom(
              background: Colors.amber,
              title: 'creer un produit',
              color: Colors.white,
              width: 220.0,
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) =>
                          ShowCreateProductDialog(activityId: widget.id),
                );
              },
            ),

            const SizedBox(height: 20),

            // Entête de la liste des produits
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Produits associés:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, provider, _) {
                  switch (provider.state) {
                    case ProductState.loading:
                      return const Center(child: CircularProgressIndicator());

                    case ProductState.error:
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Erreur de chargement: ${provider.errorMessage}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      );

                    case ProductState.loaded:
                    case ProductState.initial:
                      if (provider.products.isEmpty) {
                        return const Center(
                          child: Text(
                            "Aucun produit ajouté pour cette activité. Ajoutez-en un !",
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: provider.products.length,
                        itemBuilder: (context, index) {
                          final ProductEntity product =
                              provider.products[index];
                          return _buildProductItem(context, product, provider);
                        },
                      );
                  }
                },
              ),
            ),

            const Text(
              'Liste des produits pour cette activité... (À implémenter)',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(
    BuildContext context,
    ProductEntity product,
    ProductProvider provider,
  ) {
    final formattedPrice = NumberFormatter.formatAmount(
      amount: product.price,
      symbol: ' Ar',
    );
    return ListTile(
      title: Text(product.name),
      subtitle: Text(
        'Prix: $formattedPrice - Quantité: ${product.requiredTickets}',
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          // Appel à la suppression. Assurez-vous d'avoir l'ID non null.
          if (product.id != null) {
            _showDeleteConfirmationDialog(context, product, provider);
          }
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    ProductEntity product,
    ProductProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: Text(
            'Voulez-vous vraiment supprimer le produit "${product.name}" ?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Supprime le produit et ferme le dialogue
                provider.deleteProduct(id: product.id!);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
