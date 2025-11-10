import 'package:flutter/material.dart';
import '../widgets/menu_card.dart';

class HomePage extends StatelessWidget {
  final void Function(int) onTapMenu; // callback

  const HomePage({required this.onTapMenu, super.key});

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
          MenuCard(
            icon: Icons.calculate,
            title: 'Kalkulator Gizi',
            color: Colors.red,
            onTap: () => onTapMenu(1), // index GiziPage
          ),
          MenuCard(
            icon: Icons.restaurant_menu,
            title: 'Resep',
            color: Colors.green,
            onTap: () => onTapMenu(2), // index RecipesPage
          ),
          MenuCard(
            icon: Icons.bookmark,
            title: 'Bookmark',
            color: Colors.blue,
            onTap: () => onTapMenu(3), // index BookmarkPage
          ),
          MenuCard(
            icon: Icons.person,
            title: 'Profil',
            color: Colors.orange,
            onTap: () => onTapMenu(4), // index ProfilePage
          ),
        ],
      ),
    );
  }
}
