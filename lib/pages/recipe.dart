import 'package:flutter/material.dart';

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
