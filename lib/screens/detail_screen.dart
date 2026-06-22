import 'package:flutter/material.dart';

import '../data/cart_data.dart';
import '../models/product_model.dart';
import '../widgets/cart_action_button.dart';
import 'cart_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  static const String routeName = '/detail';

  void _addToCart(BuildContext context, Product product) {
    cartStore.addProduct(product);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ürün sepete eklendi.'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Sepete Git',
          onPressed: () {
            Navigator.pushNamed(context, CartScreen.routeName);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is! Product) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Ürün Detayı'),
          actions: const [CartActionButton()],
        ),
        body: const Center(child: Text('Ürün bilgisi bulunamadı.')),
      );
    }

    final Product product = arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Detayı'),
        actions: const [CartActionButton()],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: ElevatedButton.icon(
          onPressed: () => _addToCart(context, product),
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text('Sepete Ekle'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ProductImage(product: product),
            _ProductInfo(product: product),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Hero(
        tag: 'product-image-${product.id}',
        child: Image.network(
          product.image,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.image_not_supported_outlined,
              size: 64,
              color: Color(0xFF9CA3AF),
            );
          },
        ),
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  const _ProductInfo({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CategoryChip(category: product.category),
          const SizedBox(height: 14),
          Text(
            product.title,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 26,
              fontWeight: FontWeight.bold,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Açıklama',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: const TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 22),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Text(
                  'Fiyat',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF0A36D9),
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF0A36D9).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: Color(0xFF0A36D9),
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
