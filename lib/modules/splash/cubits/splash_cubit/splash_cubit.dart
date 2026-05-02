import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../../../core/services/local/cache_client.dart';
import '../../../../core/services/local/storage_keys.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._cacheClient) : super(const SplashState());

  final CacheClient _cacheClient;

  Future<void> init() async {
    emit(state.copyWith(status: RequestStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    final token = await _cacheClient.getSecureString(StorageKeys.accessToken);
    emit(state.copyWith(
      status: RequestStatus.success,
      isAuthenticated: token != null && token.isNotEmpty,
    ));
  }
}