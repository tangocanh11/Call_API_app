// Food Model
class Food {
  final String id;
  final String name;
  final String description;
  final String category;
  final double calories;
  final String imageUrl;
  final List<String> ingredients;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.calories,
    required this.imageUrl,
    required this.ingredients,
  });

  // Factory constructor to create Food from JSON
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'] ?? 'unknown',
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? 'No description available',
      category: json['category'] ?? 'Other',
      calories: (json['calories'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/300',
      ingredients: List<String>.from(json['ingredients'] ?? []),
    );
  }

  // Convert Food to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'calories': calories,
      'imageUrl': imageUrl,
      'ingredients': ingredients,
    };
  }
}
