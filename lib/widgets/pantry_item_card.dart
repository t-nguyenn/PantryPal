import 'package:flutter/material.dart';
import 'package:pantrypal/models/pantry_item.dart';
import 'package:pantrypal/theme/app_theme.dart';

class PantryItemCard extends StatelessWidget {
  final PantryItem item;
  final VoidCallback? onTap;

  const PantryItemCard({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isExpiring = item.daysUntilExpiry <= 7 && item.daysUntilExpiry > 0;
    final isExpired = item.isExpired;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.category,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.darkGreen,
                            fontSize: 11,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '${item.quantity} ${item.unit}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.emeraldGreen,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              if (isExpired)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Expired',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.error,
                          fontSize: 11,
                        ),
                  ),
                )
              else if (isExpiring)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Expires in ${item.daysUntilExpiry} days',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.warning,
                          fontSize: 11,
                        ),
                  ),
                )
              else
                Text(
                  'Expires in ${item.daysUntilExpiry} days',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
