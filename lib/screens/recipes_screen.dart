import 'package:flutter/material.dart';
import 'package:pantrypal/data/dummy_data.dart';
import 'package:pantrypal/screens/recipe_detail_screen.dart';
import 'package:pantrypal/theme/app_theme.dart';
import 'package:pantrypal/widgets/recipe_card.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  String _selectedCuisine = 'All';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cuisines = [
      'All',
      ...dummyRecipes.map((r) => r.cuisine).toSet().toList(),
    ];

    final filteredRecipes = dummyRecipes.where((recipe) {
      final matchesCuisine =
          _selectedCuisine == 'All' || recipe.cuisine == _selectedCuisine;
      final matchesSearch = recipe.name
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
      return matchesCuisine && matchesSearch;
    }).toList();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recipe Ideas',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search recipes',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cuisines.length,
                itemBuilder: (context, index) {
                  final cuisine = cuisines[index];
                  final isSelected = _selectedCuisine == cuisine;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(cuisine),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCuisine = cuisine;
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: AppColors.emeraldGreen.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: isSelected
                            ? AppColors.emeraldGreen
                            : AppColors.lightText,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.emeraldGreen
                            : AppColors.border,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            if (filteredRecipes.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.restaurant_menu,
                        size: 64,
                        color: AppColors.lightText.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No recipes found',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.lightText,
                            ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: RecipeCard(
                      recipe: filteredRecipes[index],
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                RecipeDetailScreen(recipe: filteredRecipes[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
