# Praktikum Pemrograman Perangkat Bergerak Lanjut (PPBL)
## Modul 3: State Management & Interaksi pada Flutter

Repositori ini memuat implementasi kode sumber untuk **Praktikum Modul 3** pada mata kuliah Pemrograman Perangkat Bergerak Lanjut.

### Identitas Mahasiswa
- **Nama**: Falih Afnan Fauzi
- **NIM**: 707012400017
- **Kelas**: D4SM-48-03
- **Program Studi**: D4 Sistem Informasi Kota Cerdas
- **Fakultas**: Fakultas Ilmu Terapan, Universitas Telkom

---

### Struktur Repositori
1. **`state_interaksi_707012400017/`**
   - Proyek Praktikum Mandiri: Aplikasi Pemesanan Kantin Kampus Telkom University.
   - Mengimplementasikan `ChangeNotifierProvider` untuk `KeranjangModel`, local state `setState()`, `Consumer`, `context.read`, dan `context.select`.
2. **`nusantara_cerdas_nav_707012400017/`**
   - Proyek Tugas Praktikum: Ekstensi Aplikasi Portal Nusantara Cerdas dengan State Management.
   - Mengimplementasikan `MultiProvider` di root aplikasi untuk mengelola `FavoritModel` dan `PengajuanModel`.
   - Mengintegrasikan interaksi toggle favorit (`context.read` / `context.watch`), penandaan badge pengajuan reaktif (`context.select`), efek loading pengiriman formulir lokal (`setState()`), serta tampilan reaktif tab Warga menggunakan `Consumer`.
