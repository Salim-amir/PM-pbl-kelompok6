import 'package:flutter/material.dart';
import '../widgets/logout_button.dart'; // Import file yang baru dibuat

class _MenuItem {
  final String label;
  final IconData icon;
  final Color color;
  const _MenuItem({required this.label, required this.icon, required this.color});
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<_MenuItem> _menuItems = [
    _MenuItem(label: 'Profil Saya', icon: Icons.person_rounded, color: Color(0xFF388E3C)),
    _MenuItem(label: 'Riwayat', icon: Icons.history_rounded, color: Color(0xFF0288D1)),
    _MenuItem(label: 'Notifikasi', icon: Icons.notifications_rounded, color: Color(0xFFF57C00)),
    _MenuItem(label: 'Laporan', icon: Icons.bar_chart_rounded, color: Color(0xFF7B1FA2)),
    _MenuItem(label: 'Dokumen', icon: Icons.folder_rounded, color: Color(0xFF00796B)),
    _MenuItem(label: 'Bantuan', icon: Icons.help_rounded, color: Color(0xFFD32F2F)),
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
        title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          // Menggunakan helper logout
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
            onPressed: () => LogoutHelper.confirmLogout(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _WelcomeBanner(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Menu Utama', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 14),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.95,
                    ),
                    itemCount: _menuItems.length,
                    itemBuilder: (context, index) => _GridCard(item: _menuItems[index]),
                  ),
                  const SizedBox(height: 28),
                  Text('Aktivitas Terbaru', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 14),
                  ..._buildActivityList(context),
                  const SizedBox(height: 24),
                  
                  // Menggunakan widget tombol logout yang dipisah
                  const LogoutOutlinedButton(),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActivityList(BuildContext context) {
    final activities = [
      ('Login berhasil', 'Baru saja', Icons.login_rounded, Colors.green),
      ('Profil diperbarui', '2 jam lalu', Icons.edit_rounded, Colors.blue),
      ('Password diubah', 'Kemarin', Icons.lock_reset_rounded, Colors.orange),
    ];

    return activities.map((item) => Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: item.$4.withOpacity(0.15),
          child: Icon(item.$3, color: item.$4, size: 22),
        ),
        title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(item.$2),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    )).toList();
  }
}

// Widget _WelcomeBanner dan _GridCard tetap di bawah atau bisa dipindah ke folder widgets juga
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
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Halo, Budi! 👋', 
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Senin, 16 Maret 2026', style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13)),
              ],
            ),
          ),
          Icon(Icons.eco_rounded, size: 44, color: Colors.white.withOpacity(0.4)),
        ],
      ),
    );
  }
}

class _GridCard extends StatelessWidget {
  final _MenuItem item;
  const _GridCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${item.label} — segera hadir!'), behavior: SnackBarBehavior.floating),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: item.color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: item.color.withOpacity(0.25), width: 1.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: item.color.withOpacity(0.15),
              child: Icon(item.icon, color: item.color, size: 26),
            ),
            const SizedBox(height: 10),
            Text(item.label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: item.color)),
          ],
        ),
      ),
    );
  }
}