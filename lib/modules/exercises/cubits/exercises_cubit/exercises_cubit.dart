import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../models/requests/exercises_request.dart';
import '../../repositories/exercises_repository.dart';
import 'exercises_state.dart';

class ExercisesCubit extends Cubit<ExercisesState> {
  ExercisesCubit(this._repository) : super(const ExercisesState());

  final ExercisesRepository _repository;

  Future<void> loadExercises({String? type}) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final result = await _repository.getExercises(
      ExercisesRequest(type: type),
    );
    result.fold(
      (failure) => emit(
          state.copyWith(status: RequestStatus.failure, failure: failure)),
      (exercises) => emit(
          state.copyWith(status: RequestStatus.success, exercises: exercises)),
    );
  }
}