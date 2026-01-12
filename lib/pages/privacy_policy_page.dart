import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kebijakan Privasi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: const Text('''
Kebijakan Privasi

Kami menghargai privasi pengguna aplikasi ini. Informasi yang dikumpulkan hanya digunakan untuk mendukung fungsi aplikasi.

Data yang Dikumpulkan:
- Informasi profil bayi
- Data penggunaan aplikasi

Penggunaan Data:
- Menyediakan fitur perhitungan gizi
- Menyimpan preferensi pengguna

Keamanan Data:
Kami menjaga data pengguna dengan standar keamanan yang wajar.

Perubahan Kebijakan:
Kebijakan ini dapat diperbarui sewaktu-waktu.
          ''', style: TextStyle(height: 1.6)),
      ),
    );
  }
}
