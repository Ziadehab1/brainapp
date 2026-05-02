class GamesRequest {
  const GamesRequest({this.page = 1, this.perPage = 20, this.category});

  final int page;
  final int perPage;
  final String? category;

  Map<String, dynamic> toQueryParams() => {
        'page': page,
        'per_page': perPage,
        if (category != null) 'category': category,
      };
}