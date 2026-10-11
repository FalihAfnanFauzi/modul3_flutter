import 'package:flutter/material.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, dynamic>> pilarSmartCity = [
      {
        'judul': 'Smart Governance',
        'sub': 'Tata Kelola Digital',
        'deskripsi':
            'Pelayanan birokrasi digital terpadu, transparansi data publik, dan percepatan perizinan satu pintu.',
        'ikon': Icons.gavel_rounded,
        'warna': Colors.blue,
      },
      {
        'judul': 'Smart Economy',
        'sub': 'Ekonomi & Usaha',
        'deskripsi':
            'Pemberdayaan UMKM digital, ekosistem transaksi nir-tunai, dan pusat inkubasi inovasi ekonomi kreatif.',
        'ikon': Icons.trending_up_rounded,
        'warna': Colors.teal,
      },
      {
        'judul': 'Smart Living',
        'sub': 'Kenyamanan Warga',
        'deskripsi':
            'Fasilitas kesehatan modern, kualitas lingkungan hunian prima, serta jaminan keselamatan warga 24 jam.',
        'ikon': Icons.health_and_safety_rounded,
        'warna': Colors.redAccent,
      },
      {
        'judul': 'Smart Society',
        'sub': 'Masyarakat Berdaya',
        'deskripsi':
            'Peningkatan literasi digital, pendidikan inklusif, dan partisipasi aktif warga dalam pembangunan.',
        'ikon': Icons.people_alt_rounded,
        'warna': Colors.purple,
      },
      {
        'judul': 'Smart Environment',
        'sub': 'Lingkungan Hijau',
        'deskripsi':
            'Pemanfaatan energi terbarukan ramah lingkungan, pemantauan kualitas udara, dan daur ulang pintar.',
        'ikon': Icons.eco_rounded,
        'warna': Colors.green,
      },
      {
        'judul': 'Smart Mobility',
        'sub': 'Transportasi Cerdas',
        'deskripsi':
            'Armada bus listrik terpadu, sistem manajemen lalu lintas cerdas, serta jalur sepeda terintegrasi.',
        'ikon': Icons.electric_car_rounded,
        'warna': Colors.orange,
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Banner Sambutan
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_city_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Portal Warga Nusantara Cerdas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Selamat datang di pusat layanan terpadu Kota Nusantara. Akses kemudahan perizinan, kesehatan, transportasi, dan pemantauan 6 pilar smart city dalam satu genggaman.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.95),
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Section Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Enam Pilar Smart City Nusantara',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(
              Icons.stars_rounded,
              color: theme.colorScheme.primary,
              size: 20,
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 6 Pilar Cards
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pilarSmartCity.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final pilar = pilarSmartCity[index];
            final Color pilarColor = pilar['warna'] as Color;

            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: pilarColor.withValues(alpha: 0.25),
                  width: 1.2,
                ),
              ),
              color: pilarColor.withValues(alpha: 0.06),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: pilarColor.withValues(alpha: 0.2),
                      child: Icon(
                        pilar['ikon'] as IconData,
                        color: pilarColor,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pilar['judul'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            pilar['sub'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: pilarColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            pilar['deskripsi'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onSurfaceVariant,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),

        // Card Pengujian Route Tidak Terdaftar
        Card(
          elevation: 0,
          color: theme.colorScheme.errorContainer.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: theme.colorScheme.error.withValues(alpha: 0.3),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.bug_report_outlined,
                  color: theme.colorScheme.error,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Uji Penanganan Rute',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'Menguji pemanggilan rute tidak dikenal (onUnknownRoute).',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/rute_tidak_terdaftar');
                  },
                  child: const Text('Uji /salah'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
