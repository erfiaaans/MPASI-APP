import 'package:flutter/material.dart';

class GiziPage extends StatefulWidget {
  const GiziPage({super.key});

  @override
  State<GiziPage> createState() => _GiziPageState();
}

class _GiziPageState extends State<GiziPage> {
  final TextEditingController _beratController = TextEditingController();
  String _makanan = 'Nasi';
  double _totalKalori = 0;

  final Map<String, double> _kaloriPer100Gram = {
    'Nasi': 130,
    'Ayam': 165,
    'Telur': 155,
    'Tahu': 76,
    'Wortel': 41,
  };

  void _hitungKalori() {
    final berat = double.tryParse(_beratController.text);
    if (berat == null || berat <= 0) return;

    final kaloriPer100 = _kaloriPer100Gram[_makanan] ?? 0;
    final kalori = (kaloriPer100 / 100) * berat;

    setState(() {
      _totalKalori += kalori;
    });
  }

  void _reset() {
    setState(() {
      _totalKalori = 0;
      _beratController.clear();
      _makanan = 'Nasi';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Hitung Kalori Makanan Bayi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _makanan,
              decoration: InputDecoration(
                labelText: 'Pilih Makanan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: _kaloriPer100Gram.keys.map((nama) {
                return DropdownMenuItem(value: nama, child: Text(nama));
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _makanan = val!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _beratController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Berat (gram)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _hitungKalori,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.calculate),
                  label: const Text('Hitung'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Total Kalori: ${_totalKalori.toStringAsFixed(2)} kkal',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
