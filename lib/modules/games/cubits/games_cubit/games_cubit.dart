import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../models/requests/games_request.dart';
import '../../repositories/games_repository.dart';
import 'games_state.dart';

class GamesCubit extends Cubit<GamesState> {
  GamesCubit(this._repository) : super(const GamesState());

  final GamesRepository _repository;

  Future<void> loadGames({String? category}) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final result = await _repository.getGames(
      GamesRequest(category: category),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(status: RequestStatus.failure, failure: failure)),
      (games) =>
          emit(state.copyWith(status: RequestStatus.success, games: games)),
    );
  }
}