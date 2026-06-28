import 'package:flutter/material.dart';
import 'package:pantrypal/data/dummy_data.dart';
import 'package:pantrypal/screens/item_detail_screen.dart';
import 'package:pantrypal/screens/add_item_screen.dart';
import 'package:pantrypal/theme/app_theme.dart';
import 'package:pantrypal/widgets/pantry_item_card.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All',
      'Vegetables',
      'Meat',
      'Dairy',
      'Grains',
      'Oils & Condiments',
      'Herbs',
    ];

    final filteredItems = _selectedCategory == 'All'
        ? dummyPantryItems
        : dummyPantryItems
            .where((item) => item.category == _selectedCategory)
            .toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.emeraldGreen,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddItemScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Pantry',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
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
            if (filteredItems.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.shopping_basket,
                        size: 64,
                        color: AppColors.lightText.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No items in this category',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.lightText,
                            ),
                      ),
                    ],
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return PantryItemCard(
                    item: filteredItems[index],
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ItemDetailScreen(
                            item: filteredItems[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
