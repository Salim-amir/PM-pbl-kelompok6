// ============================================================
// FITUR 3: Home Dashboard
// FILE: lib/features/home/screens/home_screen.dart
// BRANCH: feature/home
// DIKERJAKAN OLEH: [nama anggota tim]
// ============================================================
//
// File ini HANYA berisi tampilan Home Dashboard.
// Logika logout ada di: lib/features/home/widgets/logout_helper.dart
// (dikerjakan anggota tim yang berbeda)
//
// ============================================================

import 'package:flutter/material.dart';

// Import logout dari file terpisah di folder yang sama
import '../widgets/logout_helper.dart';

// Model sederhana untuk item menu grid
class _MenuItem {
  final String label;
  final IconData icon;
  final Color color;

  const _MenuItem({
    required this.label,
    required this.icon,
    required this.color,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Daftar menu grid — mudah ditambah atau dikurangi
  static const List<_MenuItem> _menuItems = [
    _MenuItem(
      label: 'Profil Saya',
      icon: Icons.person_rounded,
      color: Color(0xFF388E3C),
    ),
    _MenuItem(
      label: 'Riwayat',
      icon: Icons.history_rounded,
      color: Color(0xFF0288D1),
    ),
    _MenuItem(
      label: 'Notifikasi',
      icon: Icons.notifications_rounded,
      color: Color(0xFFF57C00),
    ),
    _MenuItem(
      label: 'Laporan',
      icon: Icons.bar_chart_rounded,
      color: Color(0xFF7B1FA2),
    ),
    _MenuItem(
      label: 'Dokumen',
      icon: Icons.folder_rounded,
      color: Color(0xFF00796B),
    ),
    _MenuItem(
      label: 'Bantuan',
      icon: Icons.help_rounded,
      color: Color(0xFFD32F2F),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final green = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: green,
        foregroundColor: Colors.white,
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          // Ikon notifikasi
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          // Tombol logout di AppBar — pakai LogoutHelper dari file lain
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
            onPressed: () => LogoutHelper.confirm(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Banner Selamat Datang ----
            const _WelcomeBanner(),
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- Label Menu Utama ----
                  Text(
                    'Menu Utama',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // ---- Grid Menu ----
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.95,
                    ),
                    itemCount: _menuItems.length,
                    itemBuilder: (context, index) {
                      return _GridCard(item: _menuItems[index]);
                    },
                  ),
                  const SizedBox(height: 28),

                  // ---- Aktivitas Terbaru ----
                  Text(
                    'Aktivitas Terbaru',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ..._buildActivityList(context),
                  const SizedBox(height: 24),

                  // ---- Tombol Logout ----
                  // Widget LogoutButton berasal dari logout_helper.dart
                  // Dikerjakan oleh anggota tim yang berbeda
                  const LogoutButton(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Daftar aktivitas statis sebagai contoh data
  List<Widget> _buildActivityList(BuildContext context) {
    final activities = [
      ('Login berhasil',    'Baru saja',  Icons.login_rounded,      Colors.green),
      ('Profil diperbarui', '2 jam lalu', Icons.edit_rounded,       Colors.blue),
      ('Password diubah',   'Kemarin',    Icons.lock_reset_rounded, Colors.orange),
    ];

    return activities.map((item) {
      return Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: item.$4.withOpacity(0.15),
            child: Icon(item.$3, color: item.$4, size: 22),
          ),
          title: Text(
            item.$1,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(item.$2),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        ),
      );
    }).toList();
  }
}

// ----------------------------------------------------------
// Widget Banner Selamat Datang (privat, hanya untuk Home)
// ----------------------------------------------------------
class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner();

  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).colorScheme.primary;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [green, Colors.green.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage:
                NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, Budi! 👋',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Senin, 16 Maret 2026',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.eco_rounded,
            size: 44,
            color: Colors.white.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------
// Widget Kartu Grid Menu (privat, hanya untuk Home)
// ----------------------------------------------------------
class _GridCard extends StatelessWidget {
  final _MenuItem item;

  const _GridCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.label} — fitur segera hadir!'),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          color: item.color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: item.color.withOpacity(0.25),
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, color: item.color, size: 26),
            ),
            const SizedBox(height: 10),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: item.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}