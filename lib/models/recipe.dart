class Recipe {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String cuisine;
  final int prepTime; // in minutes
  final int cookTime; // in minutes
  final int servings;
  final String? imageUrl;
  final double difficulty; // 1.0 to 5.0

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.cuisine,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    this.imageUrl,
    required this.difficulty,
  });

  int get totalTime => prepTime + cookTime;
}
