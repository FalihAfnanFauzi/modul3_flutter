import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pengajuan_model.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;
  bool _paksaLebar = false;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  final List<String> _judul = const [
    'Nusantara Cerdas',
    'Layanan Publik',
    'Identitas Warga',
  ];

  void _pilihTujuan(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  void _konfirmasiKeluar() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.logout_rounded, color: Colors.red),
            SizedBox(width: 10),
            Text('Keluar Akun'),
          ],
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari sesi aplikasi Nusantara Cerdas Mobile?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sesi pengguna telah diakhiri.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Membaca lebar layar untuk tata letak adaptif (ambang 600 piksel)
    final double lebar = MediaQuery.of(context).size.width;
    final bool layarLebar = lebar >= 600 || _paksaLebar;

    // PopScope mencegah aplikasi tertutup mendadak jika pengguna menekan tombol kembali saat di tab lain
    return PopScope(
      canPop: _indeksTerpilih == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _indeksTerpilih != 0) {
          setState(() {
            _indeksTerpilih = 0;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_judul[_indeksTerpilih]),
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(_paksaLebar ? Icons.smartphone_rounded : Icons.view_sidebar_rounded),
              tooltip: _paksaLebar ? 'Mode Layar Sempit (NavigationBar)' : 'Mode Layar Lebar (NavigationRail)',
              onPressed: () {
                setState(() {
                  _paksaLebar = !_paksaLebar;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_paksaLebar
                        ? 'Mode NavigationRail layar lebar diaktifkan!'
                        : 'Mode NavigationBar layar sempit diaktifkan!'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
        drawer: _buatDrawer(),
        // Tata letak adaptif: NavigationRail untuk layar lebar dan konten biasa untuk layar sempit
        body: layarLebar ? _tataLetakLebar() : _halaman[_indeksTerpilih],
        // NavigationBar disembunyikan jika pada layar lebar
        bottomNavigationBar: layarLebar ? null : _buatBilahBawah(),
      ),
    );
  }

  // Bilah Navigasi Bawah (Material 3) untuk layar sempit (< 600px)
  Widget _buatBilahBawah() {
    return NavigationBar(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: _pilihTujuan,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Beranda',
        ),
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard_rounded),
          label: 'Layanan',
        ),
        NavigationDestination(
          icon: _BadgeIkonWarga(isSelected: false),
          selectedIcon: _BadgeIkonWarga(isSelected: true),
          label: 'Warga',
        ),
      ],
    );
  }

  // Tata letak layar lebar (>= 600px): NavigationRail di kiri + konten di kanan
  Widget _tataLetakLebar() {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _indeksTerpilih,
          onDestinationSelected: _pilihTujuan,
          extended: true,
          leading: const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircleAvatar(
              radius: 24,
              child: Icon(Icons.location_city_rounded),
            ),
          ),
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: Text('Beranda'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard_rounded),
              label: Text('Layanan'),
            ),
            NavigationRailDestination(
              icon: _BadgeIkonWarga(isSelected: false),
              selectedIcon: _BadgeIkonWarga(isSelected: true),
              label: Text('Warga'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(child: _halaman[_indeksTerpilih]),
      ],
    );
  }

  // Panel Samping (NavigationDrawer)
  Widget _buatDrawer() {
    return NavigationDrawer(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: (indeks) {
        _pilihTujuan(indeks);
        Navigator.pop(context); // Tutup drawer terlebih dahulu
      },
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text(
            'Falih Afnan F',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          accountEmail: Text('NIM: 707012400017 • Warga IKN'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 38, color: Colors.teal),
          ),
          decoration: BoxDecoration(
            color: Colors.teal,
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: Text('Beranda'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard_rounded),
          label: Text('Layanan'),
        ),
        const NavigationDrawerDestination(
          icon: _BadgeIkonWarga(isSelected: false),
          selectedIcon: _BadgeIkonWarga(isSelected: true),
          label: Text('Warga'),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(),
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Pengaturan Kota'),
          onTap: () {
            Navigator.pop(context); // Tutup drawer terlebih dahulu
            Navigator.pushNamed(context, AppRoutes.pengaturanKota);
          },
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Tentang Aplikasi'),
          onTap: () {
            Navigator.pop(context); // Tutup drawer terlebih dahulu
            Navigator.pushNamed(context, AppRoutes.tentangAplikasi);
          },
        ),
        ListTile(
          leading: const Icon(Icons.bug_report_outlined, color: Colors.orange),
          title: const Text('Uji Rute Tak Dikenal (404)'),
          onTap: () {
            Navigator.pop(context); // Tutup drawer terlebih dahulu
            Navigator.pushNamed(context, '/rute_tidak_ada');
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(),
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Keluar', style: TextStyle(color: Colors.red)),
          onTap: () {
            Navigator.pop(context); // Tutup drawer terlebih dahulu
            _konfirmasiKeluar();
          },
        ),
      ],
    );
  }
}

// Widget khusus Badge Ikon Warga menggunakan context.select
class _BadgeIkonWarga extends StatelessWidget {
  final bool isSelected;
  const _BadgeIkonWarga({this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    // context.select hanya memicu rebuild jika nilai totalPengajuan berubah
    final totalPengajuan = context.select<PengajuanModel, int>(
      (model) => model.totalPengajuan,
    );

    final iconWidget = Icon(
      isSelected ? Icons.person_rounded : Icons.person_outline,
    );

    if (totalPengajuan > 0) {
      return Badge(
        label: Text('$totalPengajuan'),
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        child: iconWidget,
      );
    }

    return iconWidget;
  }
}
