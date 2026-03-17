// ============================================================
// FILE: lib/main.dart
// ⚠️  JANGAN DIMODIFIKASI — File inti bersama (shared core)
// ============================================================
//
// Hanya berisi konfigurasi tema dan pendaftaran route.
// Setiap developer cukup menambahkan route mereka di sini.
//
// ============================================================

import 'package:flutter/material.dart';

// ---- Import fitur (satu per folder fitur) ----
import 'features/login/screens/login_screen.dart';
import 'features/register/screens/register_screen.dart';
import 'features/home/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green App',
      debugShowCheckedModeBanner: false,

      // ---- Tema Hijau Material 3 ----
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32), // hijau tua
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        // Input field tampil konsisten di semua layar
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.green.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
          ),
        ),
        // Card tampil konsisten
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        // AppBar bersih tanpa bayangan
        appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
        // ElevatedButton default
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size(double.infinity, 52),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      // Mulai dari layar login
      initialRoute: '/login',

      // ---- Daftar Route ----
      routes: {
        '/login': (context) => const LoginScreen(), // Fitur 1
        '/register': (context) => const RegisterScreen(), // Fitur 2
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
