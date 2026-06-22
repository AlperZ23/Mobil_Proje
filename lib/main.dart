import 'package:flutter/material.dart';

import 'screens/detail_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MiniCatalogApp());
}

/// Uygulamanın ana widget'ı.
///
/// MaterialApp burada tanımlanır.
/// Tema, route yapısı ve başlangıç ekranı bu dosyada ayarlanır.
class MiniCatalogApp extends StatelessWidget {
  const MiniCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog Uygulaması',
      debugShowCheckedModeBanner: false,

      /// Uygulama genelinde kullanılacak tema ayarları.
      theme: ThemeData(
        useMaterial3: true,

        /// Ana renk şeması.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A36D9),
        ),

        /// Sayfa arka plan rengi.
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),

        /// AppBar genel görünümü.
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF111827),
          titleTextStyle: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        /// Buton genel görünümü.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            backgroundColor: const Color(0xFF0A36D9),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      /// Uygulamanın ilk açılacak ekranı.
      initialRoute: HomeScreen.routeName,

      /// Basit route sistemi.
      ///
      /// Detay sayfasına veri aktarımı Navigator.pushNamed ile
      /// Route Arguments mantığı kullanılarak yapılır.
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        DetailScreen.routeName: (context) => const DetailScreen(),
      },
    );
  }
}