import 'package:flutter/material.dart';
import '../widgets/menu_card.dart';

class HomePage extends StatelessWidget {
  final void Function(int) onTapMenu;
  final void Function(String query) onOpenRecipeWithQuery;

  const HomePage({
    super.key,
    required this.onTapMenu,
    required this.onOpenRecipeWithQuery,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 HEADER USER
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: const AssetImage('assets/icons/profile.png'),
                  backgroundColor: Colors.grey.shade200,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Halo 👋',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Erfia Nadia Safari',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              'Pantau gizi dan MPASI si kecil dengan mudah',
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 20),

            // 🔥 REKOMENDASI MPASI
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                onOpenRecipeWithQuery('bubur');
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade400, Colors.orange.shade600],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.child_friendly,
                      color: Colors.white,
                      size: 40,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Rekomendasi MPASI',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Sesuaikan menu dengan usia bayi',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Menu Utama',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                  onTap: () => onTapMenu(1),
                ),
                MenuCard(
                  icon: Icons.restaurant_menu,
                  title: 'Resep',
                  color: Colors.green,
                  onTap: () => onTapMenu(2),
                ),
                MenuCard(
                  icon: Icons.bookmark,
                  title: 'Bookmark',
                  color: Colors.blue,
                  onTap: () => onTapMenu(3),
                ),
                MenuCard(
                  icon: Icons.person,
                  title: 'Profil',
                  color: Colors.orange,
                  onTap: () => onTapMenu(4),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
