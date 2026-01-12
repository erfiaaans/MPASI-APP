import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Syarat & Ketentuan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: const Text('''
Syarat dan Ketentuan

Dengan menggunakan aplikasi ini, pengguna menyetujui seluruh ketentuan berikut:

1. Aplikasi digunakan sebagai alat bantu informasi gizi.
2. Hasil perhitungan bukan pengganti saran medis.
3. Pengguna bertanggung jawab atas data yang dimasukkan.
4. Kami tidak bertanggung jawab atas kesalahan penggunaan.

Ketentuan ini dapat berubah sewaktu-waktu.
          ''', style: TextStyle(height: 1.6)),
      ),
    );
  }
}
