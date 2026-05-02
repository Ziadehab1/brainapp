import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  static const Failure network =
      Failure(message: 'No internet connection', statusCode: 0);
  static const Failure unknown =
      Failure(message: 'An unexpected error occurred', statusCode: -1);
  static const Failure unauthorized =
      Failure(message: 'Unauthorized access', statusCode: 401);

  @override
  List<Object?> get props => [message, statusCode];
}