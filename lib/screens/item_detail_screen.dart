import 'package:flutter/material.dart';
import 'package:pantrypal/models/pantry_item.dart';
import 'package:pantrypal/theme/app_theme.dart';

class ItemDetailScreen extends StatelessWidget {
  final PantryItem item;

  const ItemDetailScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(
                  Icons.shopping_basket,
                  size: 80,
                  color: AppColors.darkGreen,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              item.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item.category,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.darkGreen,
                    ),
              ),
            ),
            const SizedBox(height: 24),
            _DetailCard(
              title: 'Quantity',
              value: '${item.quantity} ${item.unit}',
              icon: Icons.inventory_2,
            ),
            _DetailCard(
              title: 'Added Date',
              value: item.addedDate.toString().split(' ')[0],
              icon: Icons.calendar_today,
            ),
            _DetailCard(
              title: 'Expiry Date',
              value: item.expiryDate.toString().split(' ')[0],
              icon: Icons.event_note,
              valueColor: item.isExpired
                  ? AppColors.error
                  : item.daysUntilExpiry <= 7
                      ? AppColors.warning
                      : AppColors.success,
            ),
            _DetailCard(
              title: 'Days Until Expiry',
              value: item.isExpired
                  ? 'Expired'
                  : '${item.daysUntilExpiry} days',
              icon: Icons.hourglass_bottom,
              valueColor: item.isExpired
                  ? AppColors.error
                  : item.daysUntilExpiry <= 7
                      ? AppColors.warning
                      : AppColors.success,
            ),
            const SizedBox(height: 24),
            if (item.daysUntilExpiry <= 7 && !item.isExpired)
              Card(
                color: AppColors.warning.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.warning),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'This item expires soon. Consider using it in your next meal!',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.warning,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else if (item.isExpired)
              Card(
                color: AppColors.error.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.error),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error,
                        color: AppColors.error,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'This item has expired. Consider removing it.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.error,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? valueColor;

  const _DetailCard({
    required this.title,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.emeraldGreen,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.lightText,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: valueColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
