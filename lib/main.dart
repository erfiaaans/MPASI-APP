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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MainPage(),
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
  String? recipeSearchQuery;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 2) {
        recipeSearchQuery = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        onTapMenu: _onItemTapped,
        onOpenRecipeWithQuery: (query) {
          setState(() {
            recipeSearchQuery = null;
          });

          Future.microtask(() {
            setState(() {
              recipeSearchQuery = query;
              _selectedIndex = 2;
            });
          });
        },
      ),
      const GiziPage(),
      RecipesPage(initialQuery: recipeSearchQuery),
      const BookmarkPage(),
      const ProfilePage(),
    ];

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
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
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
