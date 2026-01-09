import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/recipe_detail_modal.dart';

enum SortOption { nameAsc, nameDesc, ageAsc, ageDesc }

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

  List<Map<String, String>> allRecipes = [];
  List<Map<String, String>> recipes = [];

  bool isLoadingRecipes = true;
  bool isSavingBookmark = false;

  SortOption? selectedSort;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  int extractAge(String usia) {
    final match = RegExp(r'\d+').firstMatch(usia);
    return match != null ? int.parse(match.group(0)!) : 0;
  }

  Future<void> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse(recipeApi));
      final List data = jsonDecode(response.body);

      final mapped = data
          .map<Map<String, String>>(
            (e) => {
              "id": e["id"].toString(),
              "nama": e["nama"].toString(),
              "usia": e["usia"].toString(),
              "gambar": e["gambar"].toString(),
            },
          )
          .toList();

      setState(() {
        allRecipes = mapped;
        recipes = mapped;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil data resep')),
      );
    } finally {
      setState(() => isLoadingRecipes = false);
    }
  }

  void filterRecipes(String query) {
    List<Map<String, String>> filtered;

    if (query.isEmpty) {
      filtered = allRecipes;
    } else {
      final input = query.toLowerCase();
      filtered = allRecipes.where((recipe) {
        return recipe['nama']!.toLowerCase().contains(input) ||
            recipe['usia']!.toLowerCase().contains(input);
      }).toList();
    }

    recipes = filtered;

    if (selectedSort != null) {
      sortRecipes(selectedSort!, triggerSetState: false);
    } else {
      setState(() {});
    }
  }

  void sortRecipes(SortOption option, {bool triggerSetState = true}) {
    recipes.sort((a, b) {
      switch (option) {
        case SortOption.nameAsc:
          return a['nama']!.compareTo(b['nama']!);
        case SortOption.nameDesc:
          return b['nama']!.compareTo(a['nama']!);
        case SortOption.ageAsc:
          return extractAge(a['usia']!).compareTo(extractAge(b['usia']!));
        case SortOption.ageDesc:
          return extractAge(b['usia']!).compareTo(extractAge(a['usia']!));
      }
    });

    selectedSort = option;

    if (triggerSetState) setState(() {});
  }

  Future<void> saveBookmark(Map<String, String> recipe) async {
    setState(() => isSavingBookmark = true);

    try {
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

  void showSortModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          const Text(
            "Urutkan berdasarkan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          ListTile(
            title: const Text("Nama A - Z"),
            onTap: () {
              sortRecipes(SortOption.nameAsc);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Nama Z - A"),
            onTap: () {
              sortRecipes(SortOption.nameDesc);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Usia termuda"),
            onTap: () {
              sortRecipes(SortOption.ageAsc);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("Usia tertua"),
            onTap: () {
              sortRecipes(SortOption.ageDesc);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoadingRecipes
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: filterRecipes,
                          decoration: InputDecoration(
                            hintText: "Cari nama atau usia",
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      searchController.clear();
                                      filterRecipes('');
                                    },
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.sort),
                        onPressed: showSortModal,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: recipes.isEmpty
                      ? const Center(child: Text("Resep tidak ditemukan 😢"))
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
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                ),
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
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
