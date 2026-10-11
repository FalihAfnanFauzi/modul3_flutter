import 'package:flutter/material.dart';
import '../pages/halaman_detail_layanan.dart';
import '../pages/halaman_pengaturan_kota.dart';
import '../pages/halaman_riwayat_laporan.dart';
import '../pages/halaman_tentang_aplikasi.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailLayanan = '/detail_layanan';
  static const String riwayatLaporan = '/riwayat_laporan';
  static const String pengaturanKota = '/pengaturan_kota';
  static const String tentangAplikasi = '/tentang_aplikasi';

  // Daftar rute statis tanpa parameter dinamis
  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      riwayatLaporan: (context) => const HalamanRiwayatLaporan(),
      pengaturanKota: (context) => const HalamanPengaturanKota(),
      tentangAplikasi: (context) => const HalamanTentangAplikasi(),
    };
  }

  // Pembangun rute dinamis dengan arguments
  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailLayanan) {
      final data = settings.arguments as Map<String, String>? ?? const {};
      return MaterialPageRoute(
        builder: (context) => HalamanDetailLayanan(
          namaLayanan: data['namaLayanan'] ?? 'Layanan Nusantara',
          dinas: data['dinas'] ?? 'Pemerintah Kota Nusantara',
          jamOperasional: data['jamOperasional'] ?? '08.00 - 16.00 WITA',
          keterangan: data['keterangan'] ?? 'Tidak ada keterangan.',
        ),
      );
    }
    return null;
  }

  // Penanganan rute yang tidak terdaftar (onUnknownRoute)
  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Rute Tidak Ditemukan'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 72,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Galat 404 - Halaman Tidak Ada',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rute "${settings.name}" belum terdaftar pada sistem Nusantara Cerdas.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Kembali ke Halaman Sebelumnya'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
