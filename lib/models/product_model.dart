/// Ürün veri modeli.
///
/// Bu sınıf uygulama içinde tek bir ürünü temsil eder.
/// Mock JSON verileri bu modele dönüştürülerek kullanılır.
class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });

  /// JSON benzeri Map yapısından Product nesnesi üretir.
  ///
  /// Gerçek API kullanılmadığı için bu metot mock veriyi
  /// model nesnesine dönüştürmek amacıyla kullanılır.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      category: json['category'] as String,
    );
  }
}