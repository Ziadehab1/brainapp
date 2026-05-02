import 'package:equatable/equatable.dart';

class PaginationModel<T> extends Equatable {
  const PaginationModel({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.perPage,
  });

  final List<T> items;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int perPage;

  bool get hasNextPage => currentPage < totalPages;
  bool get hasPrevPage => currentPage > 1;

  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginationModel<T>(
      items: (json['data'] as List)
          .map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['current_page'] as int,
      totalPages: json['last_page'] as int,
      totalItems: json['total'] as int,
      perPage: json['per_page'] as int,
    );
  }

  @override
  List<Object?> get props =>
      [items, currentPage, totalPages, totalItems, perPage];
}