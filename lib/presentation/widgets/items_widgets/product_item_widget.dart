import 'package:association_appli/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(8.0),
      child: Container(
        height: 92.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            Text(product.name),
            Text('${product.price}'),
            Text('${product.requiredTickets}'),
          ],
        ),
      ),
    );
  }
}
