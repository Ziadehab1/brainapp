import 'package:equatable/equatable.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../../../core/base/models/pagination_model.dart';
import '../../../../core/services/error/failure.dart';
import '../../models/responses/games_response.dart';

class GamesState extends Equatable {
  const GamesState({
    this.status = RequestStatus.initial,
    this.games,
    this.failure,
  });

  final RequestStatus status;
  final PaginationModel<GameResponse>? games;
  final Failure? failure;

  GamesState copyWith({
    RequestStatus? status,
    PaginationModel<GameResponse>? games,
    Failure? failure,
  }) =>
      GamesState(
        status: status ?? this.status,
        games: games ?? this.games,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [status, games, failure];
}