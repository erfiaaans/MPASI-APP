import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/recipe_detail_modal.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  final String recipeApi =
      'https://6957da6cf7ea690182d34792.mockapi.io/api/v1/recipe';

  final String bookmarkApi =
      'https://6957da6cf7ea690182d34792.mockapi.io/api/v1/recipe-bookmarks';

  final String userId = "1";

  List<Map<String, String>> recipes = [];

  bool isLoadingRecipes = true;
  bool isSavingBookmark = false;

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  // 🔹 FETCH RECIPES
  Future<void> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse(recipeApi));
      final List data = jsonDecode(response.body);

      setState(() {
        recipes = data
            .map<Map<String, String>>(
              (e) => {
                "id": e["id"].toString(),
                "nama": e["nama"].toString(),
                "usia": e["usia"].toString(),
                "gambar": e["gambar"].toString(),
              },
            )
            .toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil data resep')),
      );
    } finally {
      setState(() {
        isLoadingRecipes = false;
      });
    }
  }

  // 🔹 SAVE BOOKMARK
  Future<void> saveBookmark(Map<String, String> recipe) async {
    setState(() => isSavingBookmark = true);

    try {
      // cek existing bookmark
      final res = await http.get(Uri.parse(bookmarkApi));
      final List data = jsonDecode(res.body);

      final exists = data.any(
        (e) => e['user_id'] == userId && e['recipe_id'] == recipe['id'],
      );

      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${recipe['nama']} sudah di bookmark')),
        );
        return;
      }

      await http.post(
        Uri.parse(bookmarkApi),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "recipe_id": recipe['id'],
          "user_id": userId,
          "created_at": null,
        }),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${recipe['nama']} disimpan ke bookmark ❤️')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal menyimpan bookmark')));
    } finally {
      setState(() => isSavingBookmark = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Resep MPASI 🥣'),
        backgroundColor: Colors.orange,
      ),
      body: isLoadingRecipes
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];

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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text("Usia ${recipe['usia']}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      showRecipeDetailModal(
                        context: context,
                        recipe: recipe,
                        actionText: isSavingBookmark
                            ? "Menyimpan..."
                            : "Simpan ke Bookmark",
                        onAction: (recipe) async {
                          if (isSavingBookmark) return;
                          await saveBookmark(recipe);
                        },
                      );
                      ;
                    },
                  ),
                );
              },
            ),
    );
  }
}
