import 'package:flutter/material.dart';
import 'package:pantrypal/data/dummy_data.dart';
import 'package:pantrypal/screens/settings_screen.dart';
import 'package:pantrypal/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            // Profile header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: AppColors.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentUser.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentUser.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.lightText,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Stats section
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    label: 'Items',
                    value: '${dummyPantryItems.length}',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    label: 'Recipes',
                    value: '${dummyRecipes.length}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Preferences section
            Text(
              'Preferences',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),

            // Dietary preferences
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dietary Preferences',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 12),
                    if (currentUser.dietaryPreferences.isEmpty)
                      Text(
                        'No preferences set',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.lightText,
                            ),
                      )
                    else
                      Wrap(
                        spacing: 8,
                        children: currentUser.dietaryPreferences
                            .map((pref) => Chip(
                                  label: Text(pref),
                                  backgroundColor: AppColors.lightGreen,
                                  labelStyle: const TextStyle(
                                    color: AppColors.darkGreen,
                                  ),
                                ))
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Allergies
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Allergies',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 12),
                    if (currentUser.allergies.isEmpty)
                      Text(
                        'No allergies set',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.lightText,
                            ),
                      )
                    else
                      Wrap(
                        spacing: 8,
                        children: currentUser.allergies
                            .map((allergy) => Chip(
                                  label: Text(allergy),
                                  backgroundColor: AppColors.error.withOpacity(0.1),
                                  labelStyle:
                                      const TextStyle(color: AppColors.error),
                                ))
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Settings button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings),
                label: const Text('Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.emeraldGreen,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.lightText,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
