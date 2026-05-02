class GameResponse {
  const GameResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficultyLevel,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final int difficultyLevel;

  factory GameResponse.fromJson(Map<String, dynamic> json) => GameResponse(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
        difficultyLevel: json['difficulty_level'] as int,
      );
}