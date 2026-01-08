// lib/pages/bookmark.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/recipe_detail_modal.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final String bookmarkApi =
      'https://6957da6cf7ea690182d34792.mockapi.io/api/v1/recipe-bookmarks';

  final String recipeApi =
      'https://6957da6cf7ea690182d34792.mockapi.io/api/v1/recipe';

  final String userId = "1";

  List<Map<String, dynamic>> bookmarks = [];
  Map<String, Map<String, String>> recipesById = {};

  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // 🔹 LOAD BOOKMARK + RECIPE
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      // fetch recipe
      final recipeRes = await http.get(Uri.parse(recipeApi));
      final List recipeData = jsonDecode(recipeRes.body);

      recipesById = {
        for (var r in recipeData)
          r['id']: {
            "id": r['id'].toString(),
            "nama": r['nama'].toString(),
            "usia": r['usia'].toString(),
            "gambar": r['gambar'].toString(),
          },
      };

      // fetch bookmark
      final bookmarkRes = await http.get(Uri.parse(bookmarkApi));
      final List bookmarkData = jsonDecode(bookmarkRes.body);

      bookmarks = bookmarkData
          .where((e) => e['user_id'] == userId)
          .cast<Map<String, dynamic>>()
          .toList();
    } catch (e) {
      hasError = true;
    } finally {
      setState(() => isLoading = false);
    }
  }

  // 🔹 DELETE BOOKMARK
  Future<void> removeBookmark(
    Map<String, String> recipe,
    String bookmarkId,
  ) async {
    await http.delete(Uri.parse('$bookmarkApi/$bookmarkId'));
    await loadData();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${recipe['nama']} dihapus dari bookmark')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔄 Loading
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // ❌ Error
    if (hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat bookmark 😢'),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: loadData, child: const Text('Coba Lagi')),
          ],
        ),
      );
    }

    // 📭 Empty
    if (bookmarks.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada resep disimpan ❤️',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    // 📋 List
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookmarks.length,
      itemBuilder: (context, index) {
        final bookmark = bookmarks[index];
        final recipeId = bookmark['recipe_id'];

        // 🔴 recipe bisa NULL
        final recipe = recipesById[recipeId];

        // ✅ JANGAN render kalau recipe tidak ditemukan
        if (recipe == null) {
          return const SizedBox(); // atau tampilkan placeholder
        }

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                recipe['gambar']!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              recipe['nama']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Usia ${recipe['usia']}"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showRecipeDetailModal(
                context: context,
                recipe: recipe,
                actionText: "Hapus dari Bookmark",
                onAction: (_) => removeBookmark(recipe, bookmark['id']),
              );
            },
          ),
        );
      },
    );
  }
}
