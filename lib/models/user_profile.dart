class UserProfile {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final List<String> dietaryPreferences;
  final List<String> allergies;
  final bool notificationsEnabled;
  final String theme;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.dietaryPreferences = const [],
    this.allergies = const [],
    this.notificationsEnabled = true,
    this.theme = 'light',
  });
}
