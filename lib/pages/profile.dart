import 'package:flutter/material.dart';

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
