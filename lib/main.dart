import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/calculator.dart';
import 'pages/recipe.dart';
import 'pages/bookmark.dart';
import 'pages/profile.dart';

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

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(onTapMenu: _onItemTapped),
      const GiziPage(),
      RecipesPage(),
      const BookmarkPage(),
      const ProfilePage(),
    ];
  }

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
