import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/localization/cubit/l10n_cubit.dart';
import 'core/services/error/error_handler.dart';
import 'core/services/local/cache_client.dart';
import 'core/services/network/api_client.dart';
import 'core/services/network/dio_client.dart';
import 'core/services/network/network_info.dart';
import 'modules/auth/repositories/auth_repository.dart';
import 'modules/exercises/repositories/exercises_repository.dart';
import 'modules/games/repositories/games_repository.dart';
import 'modules/splash/cubits/splash_cubit/splash_cubit.dart';
import 'modules/auth/cubits/login_cubit/login_cubit.dart';
import 'modules/auth/cubits/otp_cubit/otp_cubit.dart';
import 'modules/auth/cubits/create_password_cubit/create_password_cubit.dart';
import 'modules/layout/cubits/layout_cubit/layout_cubit.dart';
import 'modules/exercises/cubits/exercises_cubit/exercises_cubit.dart';
import 'modules/games/cubits/games_cubit/games_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // --- External ---
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  getIt.registerLazySingleton<Dio>(() => Dio());

  // --- Core Services ---
  getIt.registerLazySingleton<CacheClient>(
    () => CacheClient(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  getIt.registerLazySingleton<ApiClient>(
    () => DioClient(getIt<Dio>()),
  );
  getIt.registerLazySingleton<ErrorHandler>(() => ErrorHandler());

  // --- Global Cubits (singletons) ---
  getIt.registerLazySingleton<L10nCubit>(
    () => L10nCubit(getIt<CacheClient>()),
  );

  // --- Repositories ---
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      apiClient: getIt<ApiClient>(),
      networkInfo: getIt<NetworkInfo>(),
      errorHandler: getIt<ErrorHandler>(),
    ),
  );
  getIt.registerLazySingleton<ExercisesRepository>(
    () => ExercisesRepository(
      apiClient: getIt<ApiClient>(),
      networkInfo: getIt<NetworkInfo>(),
      errorHandler: getIt<ErrorHandler>(),
    ),
  );
  getIt.registerLazySingleton<GamesRepository>(
    () => GamesRepository(
      apiClient: getIt<ApiClient>(),
      networkInfo: getIt<NetworkInfo>(),
      errorHandler: getIt<ErrorHandler>(),
    ),
  );

  // --- Feature Cubits (factories — new instance per screen) ---
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<CacheClient>()),
  );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<AuthRepository>()),
  );
  getIt.registerFactory<OtpCubit>(
    () => OtpCubit(getIt<AuthRepository>()),
  );
  getIt.registerFactory<CreatePasswordCubit>(
    () => CreatePasswordCubit(getIt<AuthRepository>()),
  );
  getIt.registerFactory<LayoutCubit>(() => LayoutCubit());
  getIt.registerFactory<ExercisesCubit>(
    () => ExercisesCubit(getIt<ExercisesRepository>()),
  );
  getIt.registerFactory<GamesCubit>(
    () => GamesCubit(getIt<GamesRepository>()),
  );
}