import 'package:flutter/material.dart';

void main() {
  runApp(const MPASIApp());
}

class MPASIApp extends StatelessWidget {
  const MPASIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi MPASI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    GiziPage(),
    RecipesPage(),
    BookmarkPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          [
            "Beranda",
            "Kalkulator Gizi",
            "Resep",
            "Bookmark",
            "Profil",
          ][_selectedIndex],
        ),
        backgroundColor: Colors.orange.shade400,
        foregroundColor: Colors.white,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),

          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Gizi'),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Resep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _pindahHalaman(BuildContext context, int index) {
    final mainState = context.findAncestorStateOfType<_MainPageState>();
    if (mainState != null) {
      mainState._onItemTapped(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        children: [
          _MenuCard(
            icon: Icons.calculate,
            title: 'Kalkulator Gizi',
            color: Colors.red,
            onTap: () {
              _pindahHalaman(context, 0); // index Gizi
            },
          ),
          _MenuCard(
            icon: Icons.restaurant_menu,
            title: 'Resep',
            color: Colors.green,
            onTap: () {
              _pindahHalaman(context, 1); // index Resep
            },
          ),
          _MenuCard(
            icon: Icons.bookmark,
            title: 'Bookmark',
            color: Colors.blue,
            onTap: () {
              _pindahHalaman(context, 2); // index Bookmark
            },
          ),
          _MenuCard(
            icon: Icons.person,
            title: 'Profil',
            color: Colors.orange,
            onTap: () {
              _pindahHalaman(context, 4); // index Profil
            },
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text(
          'Daftar Resep MPASI 🥣',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.rice_bowl),
          title: Text("Bubur Nasi Tim Salmon"),
          subtitle: Text("Usia 8-12 bulan"),
        ),
        ListTile(
          leading: Icon(Icons.food_bank),
          title: Text("Pure Ubi Ungu"),
          subtitle: Text("Usia 6-8 bulan"),
        ),
      ],
    );
  }
}

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Belum ada resep disimpan ❤️',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.orange,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        SizedBox(height: 16),
        Text('Nama Ibu: Eva Ningsih', style: TextStyle(fontSize: 18)),
        Text('Nama Bayi: Dinda', style: TextStyle(fontSize: 18)),
        Text('Usia Bayi: 8 Bulan', style: TextStyle(fontSize: 18)),
      ],
    );
  }
}

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
