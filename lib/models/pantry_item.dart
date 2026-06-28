class PantryItem {
  final String id;
  final String name;
  final String category;
  final int quantity;
  final String unit;
  final DateTime expiryDate;
  final String? imageUrl;
  final DateTime addedDate;

  PantryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    required this.expiryDate,
    this.imageUrl,
    required this.addedDate,
  });

  bool get isExpired => expiryDate.isBefore(DateTime.now());

  int get daysUntilExpiry => expiryDate.difference(DateTime.now()).inDays;
}
