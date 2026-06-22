import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobil Proje')),
      body: mockProducts.isEmpty
          ? const Center(child: Text('Urun listesi bos.'))
          : ListView.separated(
              itemCount: mockProducts.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final product = mockProducts[index];

                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Text('${product.price.toStringAsFixed(2)} TL'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => DetailScreen(product: product),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
