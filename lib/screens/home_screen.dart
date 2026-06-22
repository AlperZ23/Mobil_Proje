import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/product_model.dart';
import 'detail_screen.dart';

/// Uygulamanın ana ekranı.
///
/// Bu ekranda:
/// - Banner görseli gösterilir.
/// - Ürünler GridView.builder ile listelenir.
/// - Ürün kartına basılınca detay sayfasına gidilir.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final List<Product> products = getMockProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Katalog'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const _BannerSection(),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  const Text(
                    'Öne Çıkan Ürünler',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${products.length} ürün',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),

            /// GridView.builder ürün sayısı kadar kart üretir.
            ///
            /// Başlangıç seviyesinde listeleme mantığını öğrenmek için
            /// en uygun yapılardan biridir.
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount(context),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  final Product product = products[index];

                  return _ProductCard(
                    product: product,
                    onTap: () {
                      /// Route Arguments kullanımı:
                      ///
                      /// Seçilen ürün, arguments parametresi ile
                      /// detay sayfasına gönderilir.
                      Navigator.pushNamed(
                        context,
                        DetailScreen.routeName,
                        arguments: product,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Geniş ekranlarda daha fazla sütun göstermek için basit yardımcı metot.
  int _crossAxisCount(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (width >= 900) {
      return 4;
    }

    if (width >= 600) {
      return 3;
    }

    return 2;
  }
}

/// Ana sayfanın üst kısmındaki banner alanı.
class _BannerSection extends StatelessWidget {
  const _BannerSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 16 / 4.4,
          child: Image.network(
            'https://wantapi.com/assets/banner.png',
            fit: BoxFit.cover,

            /// Görsel yüklenemezse uygulama hata vermesin diye
            /// basit bir yedek görünüm gösterilir.
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFE5E7EB),
                alignment: Alignment.center,
                child: const Text(
                  'Banner yüklenemedi',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Tek bir ürün kartını temsil eden widget.
class _ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const _ProductCard({
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                color: const Color(0xFFF3F4F6),
                padding: const EdgeInsets.all(12),
                child: Hero(
                  tag: 'product-image-${product.id}',
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_not_supported_outlined,
                        size: 42,
                        color: Color(0xFF9CA3AF),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF0A36D9),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}