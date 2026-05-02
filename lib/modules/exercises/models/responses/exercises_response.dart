class ExerciseResponse {
  const ExerciseResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.durationSeconds,
  });

  final String id;
  final String title;
  final String description;
  final String type;
  final int durationSeconds;

  factory ExerciseResponse.fromJson(Map<String, dynamic> json) =>
      ExerciseResponse(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        type: json['type'] as String,
        durationSeconds: json['duration_seconds'] as int,
      );
}