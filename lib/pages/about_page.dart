import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang MPASI Care')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                'assets/icons/app_icon.png',
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 12),

            const Center(
              child: Text(
                'MPASI Care',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            const Center(
              child: Text('Versi 1.0.0', style: TextStyle(color: Colors.grey)),
            ),

            const SizedBox(height: 24),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.green.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Colors.green),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'MPASI Care membantu orang tua menyiapkan menu MPASI '
                        'sehat, bergizi, dan sesuai usia bayi.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: const [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Tentang Aplikasi',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              'MPASI Care adalah aplikasi panduan MPASI yang dirancang untuk '
              'membantu orang tua dalam menyiapkan menu MPASI sehat dan bergizi '
              'sesuai dengan tahapan usia bayi.\n\n'
              'Aplikasi ini menyediakan berbagai resep MPASI yang mudah diikuti '
              'dan disusun secara terstruktur untuk mendukung tumbuh kembang '
              'anak secara optimal.',
              style: TextStyle(fontSize: 14, height: 1.6),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
