// ============================================================
// FITUR 4: Logout
// FILE: lib/features/home/widgets/logout_helper.dart
// BRANCH: feature/home
// DIKERJAKAN OLEH: LILIYAN
// ============================================================
//
// File ini berisi semua logika dan UI yang berkaitan dengan logout.
// Dipanggil dari home_screen.dart — tidak perlu modifikasi main.dart.
//
// CARA PAKAI di home_screen.dart:
//   LogoutHelper.confirm(context);
//
// ============================================================

import 'package:flutter/material.dart';

class LogoutHelper {
  // Constructor privat — class ini tidak perlu di-instansiasi
  // Cukup panggil LogoutHelper.confirm(context) langsung
  LogoutHelper._();

  /// Tampilkan dialog konfirmasi logout.
  /// Jika user menekan "Keluar", semua route dibersihkan
  /// dan kembali ke halaman login.
  static void confirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: const [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 10),
            Text('Keluar'),
          ],
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari aplikasi?',
        ),
        actions: [
          // Tombol Batal — tutup dialog saja
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),

          // Tombol Keluar — hapus semua route, kembali ke login
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx); // tutup dialog dulu
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false, // hapus semua route sebelumnya
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size(80, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Widget Tombol Logout (siap pakai di mana saja)
// ----------------------------------------------------------
// Contoh pemakaian di home_screen.dart:
//   LogoutButton()
// ----------------------------------------------------------
class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () => LogoutHelper.confirm(context),
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const Text(
          'Keluar dari Akun',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}