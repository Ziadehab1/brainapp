class ExercisesRequest {
  const ExercisesRequest({this.page = 1, this.perPage = 20, this.type});

  final int page;
  final int perPage;
  final String? type;

  Map<String, dynamic> toQueryParams() => {
        'page': page,
        'per_page': perPage,
        if (type != null) 'type': type,
      };
}