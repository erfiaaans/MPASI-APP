// lib/widgets/recipe_detail_modal.dart
import 'package:flutter/material.dart';

typedef RecipeActionCallback =
    Future<void> Function(Map<String, String> recipe);

class RecipeDetailModal extends StatefulWidget {
  final Map<String, String> recipe;
  final String actionText;
  final RecipeActionCallback onAction;

  const RecipeDetailModal({
    super.key,
    required this.recipe,
    required this.actionText,
    required this.onAction,
  });

  @override
  State<RecipeDetailModal> createState() => _RecipeDetailModalState();
}

class _RecipeDetailModalState extends State<RecipeDetailModal> {
  bool isLoading = false;

  Future<void> _handleAction() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    await widget.onAction(widget.recipe);

    if (mounted) {
      setState(() => isLoading = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.recipe['nama']!),
      content: SizedBox(
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.recipe['gambar']!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text("Usia: ${widget.recipe['usia']}"),
            const SizedBox(height: 8),
            const Text(
              "Detail resep bisa ditambahkan di sini, misal bahan-bahan dan cara membuat.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : _handleAction,
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(widget.actionText),
        ),
      ],
    );
  }
}

// helper function
void showRecipeDetailModal({
  required BuildContext context,
  required Map<String, String> recipe,
  required String actionText,
  required RecipeActionCallback onAction,
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // 👈 optional (lebih aman)
    builder: (_) => RecipeDetailModal(
      recipe: recipe,
      actionText: actionText,
      onAction: onAction,
    ),
  );
}
