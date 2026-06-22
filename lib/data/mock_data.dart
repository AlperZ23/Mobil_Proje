import '../models/product_model.dart';

/// İnternetten veri çekilmez.
///
/// Bu liste, Fake Store API veya DummyJSON benzeri bir JSON cevabını
/// proje içinde taklit etmek için oluşturulmuştur.
const List<Map<String, dynamic>> mockProductJsonList = [
  {
    'id': 1,
    'title': 'Akıllı Telefon Pro',
    'description':
        'Güçlü işlemcisi, yüksek çözünürlüklü kamerası ve şık tasarımıyla günlük kullanım, fotoğraf çekimi ve mobil oyunlar için ideal bir akıllı telefon.',
    'price': 999.00,
    'image': 'https://wantapi.com/assets/images/iphone.png',
    'category': 'Telefon',
  },
  {
    'id': 2,
    'title': 'Hafif Dizüstü Bilgisayar',
    'description':
        'İnce ve hafif gövdesiyle taşınabilirliği ön planda tutan bu dizüstü bilgisayar; ders, ofis çalışmaları ve günlük üretkenlik için uygundur.',
    'price': 1299.00,
    'image': 'https://wantapi.com/assets/images/macbook_air.png',
    'category': 'Bilgisayar',
  },
  {
    'id': 3,
    'title': 'Kablosuz Kulaklık',
    'description':
        'Aktif gürültü azaltma, uzun pil ömrü ve konforlu tasarımıyla müzik dinlemek, video izlemek ve görüşme yapmak için kullanışlı bir kulaklık.',
    'price': 249.00,
    'image': 'https://wantapi.com/assets/images/airpods.png',
    'category': 'Ses',
  },
  {
    'id': 4,
    'title': 'Akıllı Saat',
    'description':
        'Sağlık takibi, bildirim yönetimi ve spor modlarıyla günlük hayatı kolaylaştıran modern ve dayanıklı bir akıllı saat.',
    'price': 399.00,
    'image': 'https://wantapi.com/assets/images/watch_series9.png',
    'category': 'Giyilebilir Teknoloji',
  },
  {
    'id': 5,
    'title': 'Taşınabilir Hoparlör',
    'description':
        'Kompakt boyutuna rağmen güçlü ses veren bu hoparlör, evde veya dış mekanda müzik keyfi için pratik bir çözümdür.',
    'price': 99.00,
    'image': 'https://wantapi.com/assets/images/homepod_mini.png',
    'category': 'Ev Teknolojisi',
  },
  {
    'id': 6,
    'title': 'Tablet Air',
    'description':
        'Geniş ekranı, hafif yapısı ve güçlü donanımı sayesinde not almak, çizim yapmak, içerik tüketmek ve ders çalışmak için uygundur.',
    'price': 599.00,
    'image': 'https://wantapi.com/assets/images/ipad_air.png',
    'category': 'Tablet',
  },
];

/// Mock JSON listesini Product listesine dönüştürür.
///
/// Bu yapı öğrencilerin API cevabı parse etme mantığını
/// internet bağlantısı kullanmadan öğrenmesini sağlar.
List<Product> getMockProducts() {
  return mockProductJsonList
      .map((productJson) => Product.fromJson(productJson))
      .toList();
}