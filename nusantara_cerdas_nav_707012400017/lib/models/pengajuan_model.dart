import 'package:flutter/foundation.dart';

class PengajuanModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _daftarPengajuan = [];

  List<Map<String, dynamic>> get daftarPengajuan => List.unmodifiable(_daftarPengajuan);

  int get totalPengajuan => _daftarPengajuan.length;

  void tambahPengajuan(Map<String, dynamic> layanan) {
    _daftarPengajuan.add({
      'nama': layanan['nama'] ?? 'Layanan Publik',
      'dinas': layanan['dinas'] ?? 'Dinas Terkait',
      'waktu': DateTime.now(),
    });
    notifyListeners();
  }

  void hapusPengajuan(int index) {
    if (index >= 0 && index < _daftarPengajuan.length) {
      _daftarPengajuan.removeAt(index);
      notifyListeners();
    }
  }

  void bersihkanPengajuan() {
    _daftarPengajuan.clear();
    notifyListeners();
  }
}
