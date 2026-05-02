import 'package:equatable/equatable.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../../../core/base/models/pagination_model.dart';
import '../../../../core/services/error/failure.dart';
import '../../models/responses/exercises_response.dart';

class ExercisesState extends Equatable {
  const ExercisesState({
    this.status = RequestStatus.initial,
    this.exercises,
    this.failure,
  });

  final RequestStatus status;
  final PaginationModel<ExerciseResponse>? exercises;
  final Failure? failure;

  ExercisesState copyWith({
    RequestStatus? status,
    PaginationModel<ExerciseResponse>? exercises,
    Failure? failure,
  }) =>
      ExercisesState(
        status: status ?? this.status,
        exercises: exercises ?? this.exercises,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [status, exercises, failure];
}