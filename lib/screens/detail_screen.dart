import 'package:flutter/material.dart';

import '../models/product_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    final selectedProduct = product;

    return Scaffold(
      appBar: AppBar(title: const Text('Detay')),
      body: selectedProduct == null
          ? const Center(child: Text('Urun detayi bos.'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    selectedProduct.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(selectedProduct.description),
                  const SizedBox(height: 16),
                  Text('${selectedProduct.price.toStringAsFixed(2)} TL'),
                ],
              ),
            ),
    );
  }
}
