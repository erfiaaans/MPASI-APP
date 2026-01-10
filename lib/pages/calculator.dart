import 'package:flutter/material.dart';

class GiziPage extends StatefulWidget {
  const GiziPage({super.key});

  @override
  State<GiziPage> createState() => _GiziPageState();
}

class _GiziPageState extends State<GiziPage> {
  final TextEditingController _beratController = TextEditingController();

  String _makanan = 'Ayam';
  double _totalKalori = 0;

  final Map<String, double> _kaloriPer100Gram = {
    'Ayam': 165,
    'Bayam': 23,
    'Brokoli': 34,
    'Daging Sapi': 250,
    'Ikan Kembung': 167,
    'Ikan Salmon': 208,
    'Jagung': 96,
    'Kentang': 77,
    'Nasi Putih': 130,
    'Pisang': 89,
    'Telur Ayam': 155,
    'Tahu': 76,
    'Tempe': 193,
    'Ubi': 86,
    'Wortel': 41,
  };

  final List<_KaloriItem> _history = [];

  void _hitungKalori() {
    final berat = double.tryParse(_beratController.text);
    if (berat == null || berat <= 0) return;

    final kaloriPer100 = _kaloriPer100Gram[_makanan] ?? 0;
    final kalori = (kaloriPer100 / 100) * berat;

    setState(() {
      _history.add(
        _KaloriItem(makanan: _makanan, berat: berat, kalori: kalori),
      );
      _totalKalori += kalori;
      _beratController.clear();
    });
  }

  void _reset() {
    setState(() {
      _history.clear();
      _totalKalori = 0;
      _beratController.clear();
      _makanan = 'Ayam';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      // appBar: AppBar(title: const Text('Kalkulator Gizi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Hitung Kalori Makanan Bayi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: _makanan,
              decoration: _inputDecoration('Pilih Makanan'),
              items: _kaloriPer100Gram.keys.map((nama) {
                return DropdownMenuItem(value: nama, child: Text(nama));
              }).toList(),
              onChanged: (val) => setState(() => _makanan = val!),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _beratController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration('Berat (gram)'),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _hitungKalori,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Hitung'),
                  style: _primaryButton(),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: _secondaryButton(),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Total Kalori',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_totalKalori.toStringAsFixed(2)} kkal',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            if (_history.isNotEmpty) ...[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rincian Perhitungan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  final item = _history[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.restaurant),
                      title: Text(item.makanan),
                      subtitle: Text('${item.berat} gram'),
                      trailing: Text(
                        '${item.kalori.toStringAsFixed(1)} kkal',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  ButtonStyle _primaryButton() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  ButtonStyle _secondaryButton() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[300],
      foregroundColor: Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

class _KaloriItem {
  final String makanan;
  final double berat;
  final double kalori;

  _KaloriItem({
    required this.makanan,
    required this.berat,
    required this.kalori,
  });
}
