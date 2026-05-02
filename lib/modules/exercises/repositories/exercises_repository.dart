import 'package:dartz/dartz.dart';

import '../../../core/base/models/pagination_model.dart';
import '../../../core/base/repositories/base_repository.dart';
import '../../../core/services/error/failure.dart';
import '../../../core/services/network/api_client.dart';
import '../../../core/services/network/endpoints.dart';
import '../models/requests/exercises_request.dart';
import '../models/responses/exercises_response.dart';

class ExercisesRepository extends BaseRepository {
  const ExercisesRepository({
    required this.apiClient,
    required super.networkInfo,
    required super.errorHandler,
  });

  final ApiClient apiClient;

  Future<Either<Failure, PaginationModel<ExerciseResponse>>> getExercises(
    ExercisesRequest request,
  ) =>
      call(() async {
        final data = await apiClient.get(
          Endpoints.exercises,
          queryParameters: request.toQueryParams(),
        );
        return PaginationModel.fromJson(
          data as Map<String, dynamic>,
          ExerciseResponse.fromJson,
        );
      });

  Future<Either<Failure, ExerciseResponse>> getExerciseById(String id) =>
      call(() async {
        final data = await apiClient.get(Endpoints.exerciseById(id));
        return ExerciseResponse.fromJson(data as Map<String, dynamic>);
      });
}