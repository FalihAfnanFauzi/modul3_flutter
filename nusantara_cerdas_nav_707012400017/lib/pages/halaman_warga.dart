import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorit_model.dart';
import '../models/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Kartu Identitas Digital Warga
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
            ),
          ),
          color: theme.colorScheme.primaryContainer.withValues(alpha: 0.25),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 46,
                  backgroundColor: theme.colorScheme.primary,
                  child: const CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.teal),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Falih Afnan F',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'NIM: 707012400017',
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Warga Terverifikasi • Kawasan Inti Pusat Pemerintahan (KIPP)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(context, 'NIK', '6471*********001'),
                    _buildStatItem(context, 'Zona', 'Sepaku A1'),
                    _buildStatItem(context, 'Status Akun', 'Aktif'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Bagian Layanan Favorit (Menggunakan Consumer<FavoritModel>)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Layanan Favorit Warga',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Consumer<FavoritModel>(
              builder: (context, favorit, _) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${favorit.daftarFavorit.length} Tersimpan',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 10),

        Consumer<FavoritModel>(
          builder: (context, favoritModel, child) {
            final daftar = favoritModel.daftarFavorit.toList();

            if (daftar.isEmpty) {
              return Card(
                elevation: 0,
                color: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.star_outline_rounded, color: theme.colorScheme.outline, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Belum ada layanan favorit. Tekan ikon bintang pada tab Layanan untuk menandai favorit.',
                          style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: daftar.map((namaLayanan) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Colors.amber.shade200,
                    ),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFEF3C7),
                      child: Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                    ),
                    title: Text(
                      namaLayanan,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    subtitle: const Text(
                      'Tersimpan di Favorit Warga',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 20),
                      tooltip: 'Hapus dari favorit',
                      onPressed: () {
                        favoritModel.batalTandai(namaLayanan);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Layanan "$namaLayanan" dihapus dari favorit.'),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 20),

        // Bagian Status Permohonan Layanan Aktif (Consumer<PengajuanModel>)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Permohonan Layanan Diajukan',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Consumer<PengajuanModel>(
              builder: (context, pengajuan, _) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${pengajuan.totalPengajuan} Pengajuan',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 10),

        Consumer<PengajuanModel>(
          builder: (context, pengajuanModel, _) {
            final daftar = pengajuanModel.daftarPengajuan;

            if (daftar.isEmpty) {
              return Card(
                elevation: 0,
                color: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.inbox_outlined, color: theme.colorScheme.outline, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Belum ada permohonan layanan yang diajukan. Buka rincian layanan dan tekan tombol Ajukan Permohonan.',
                          style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: [
                ...daftar.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final item = entry.value;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.teal.shade200),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade50,
                        child: const Icon(Icons.check_circle_outline, color: Colors.teal, size: 22),
                      ),
                      title: Text(
                        item['nama'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      subtitle: Text(
                        '${item['dinas']} • Terkirim ke Balai Kota',
                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close_rounded, size: 18),
                        tooltip: 'Batalkan Pengajuan',
                        onPressed: () {
                          pengajuanModel.hapusPengajuan(idx);
                        },
                      ),
                    ),
                  );
                }),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => pengajuanModel.bersihkanPengajuan(),
                    icon: const Icon(Icons.delete_sweep_rounded, size: 18, color: Colors.redAccent),
                    label: const Text('Bersihkan Riwayat Pengajuan', style: TextStyle(color: Colors.redAccent, fontSize: 12)),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),

        // Akses Menuju Halaman Penuh Riwayat Laporan (dengan BottomAppBar)
        Card(
          elevation: 0,
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.history_edu_rounded,
                      color: theme.colorScheme.primary,
                      size: 26,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Akses Layanan Pengaduan Penuh',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Buka halaman riwayat laporan untuk melihat status tindak lanjut petugas di lapangan, menambah laporan baru, menyaring, dan mengekspor data.',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.riwayatLaporan);
                    },
                    icon: const Icon(Icons.open_in_new_rounded),
                    label: const Text('Buka Riwayat Laporan Lengkap'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
