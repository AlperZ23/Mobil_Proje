import 'package:flutter/material.dart';

import '../models/product_model.dart';

/// Ürün detay sayfası.
///
/// StatefulWidget kullanılmasının sebebi:
/// - Sepete ekleme sayısını ekranda güncellemek.
/// - AppBar üzerindeki sepet ikonunda sayıyı artırmak.
class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  static const String routeName = '/detail';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _cartCount = 0;

  /// Sepete ekle butonuna basıldığında çalışır.
  ///
  /// setState ile ekrandaki sepet sayısı güncellenir.
  void _addToCart() {
    setState(() {
      _cartCount++;
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Sepete eklendi! Sepette $_cartCount ürün var.',
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// HomeScreen içinden arguments ile gönderilen veri burada alınır.
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;

    /// Eğer detay sayfası yanlışlıkla arguments olmadan açılırsa
    /// uygulama çökmesin diye güvenli bir hata ekranı gösterilir.
    if (arguments is! Product) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Ürün Detayı'),
        ),
        body: const Center(
          child: Text('Ürün bilgisi bulunamadı.'),
        ),
      );
    }

    final Product product = arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Detayı'),
        actions: [
          _CartIcon(count: _cartCount),
        ],
      ),

      /// Sayfanın altında sabit duran sepete ekle butonu.
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: ElevatedButton.icon(
          onPressed: _addToCart,
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

/// AppBar üzerindeki sepet ikonunu ve sayaç rozetini gösterir.
class _CartIcon extends StatelessWidget {
  final int count;

  const _CartIcon({
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          const Icon(Icons.shopping_cart_outlined),

          /// Sepette ürün yoksa rozet gösterilmez.
          if (count > 0)
            Positioned(
              right: -8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A36D9),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Detay sayfasındaki büyük ürün görseli.
class _ProductImage extends StatelessWidget {
  final Product product;

  const _ProductImage({
    required this.product,
  });

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
            color: Colors.black.withOpacity(0.06),
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

/// Detay sayfasındaki başlık, kategori, açıklama ve fiyat alanı.
class _ProductInfo extends StatelessWidget {
  final Product product;

  const _ProductInfo({
    required this.product,
  });

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

/// Ürün kategorisini küçük bir etiket olarak gösterir.
class _CategoryChip extends StatelessWidget {
  final String category;

  const _CategoryChip({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0A36D9).withOpacity(0.10),
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