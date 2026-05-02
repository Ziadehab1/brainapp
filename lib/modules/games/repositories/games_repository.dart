import 'package:dartz/dartz.dart';

import '../../../core/base/models/pagination_model.dart';
import '../../../core/base/repositories/base_repository.dart';
import '../../../core/services/error/failure.dart';
import '../../../core/services/network/api_client.dart';
import '../../../core/services/network/endpoints.dart';
import '../models/requests/games_request.dart';
import '../models/responses/games_response.dart';

class GamesRepository extends BaseRepository {
  const GamesRepository({
    required this.apiClient,
    required super.networkInfo,
    required super.errorHandler,
  });

  final ApiClient apiClient;

  Future<Either<Failure, PaginationModel<GameResponse>>> getGames(
    GamesRequest request,
  ) =>
      call(() async {
        final data = await apiClient.get(
          Endpoints.games,
          queryParameters: request.toQueryParams(),
        );
        return PaginationModel.fromJson(
          data as Map<String, dynamic>,
          GameResponse.fromJson,
        );
      });

  Future<Either<Failure, GameResponse>> getGameById(String id) =>
      call(() async {
        final data = await apiClient.get(Endpoints.gameById(id));
        return GameResponse.fromJson(data as Map<String, dynamic>);
      });

  Future<Either<Failure, void>> submitScore({
    required String gameId,
    required int score,
  }) =>
      call(() async {
        await apiClient.post(
          Endpoints.gameScore(gameId),
          data: {'score': score},
        );
      });
}