import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di_container.dart';
import '../../features/onboarding_screen/splash_screen.dart'
    as features_splash;
import '../../modules/auth/cubits/create_password_cubit/create_password_cubit.dart';
import '../../modules/auth/cubits/login_cubit/login_cubit.dart';
import '../../modules/auth/cubits/otp_cubit/otp_cubit.dart';
import '../../modules/auth/views/screens/create_password_screen.dart';
import '../../modules/auth/views/screens/login_screen.dart';
import '../../modules/auth/views/screens/otp_screen.dart';
import '../../modules/exercises/cubits/exercises_cubit/exercises_cubit.dart';
import '../../modules/exercises/views/screens/exercises_screen.dart';
import '../../modules/games/cubits/games_cubit/games_cubit.dart';
import '../../modules/games/views/screens/games_screen.dart';
import '../../modules/layout/cubits/layout_cubit/layout_cubit.dart';
import '../../modules/layout/views/screens/layout_screen.dart';
import 'platform_page_route.dart';
import 'routes.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return buildPlatformPageRoute(
          settings: settings,
          builder: (_) => const features_splash.SplashScreen(),
        );

      case Routes.login:
        return buildPlatformPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routes.otp:
        return buildPlatformPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<OtpCubit>(),
            child: const OtpScreen(),
          ),
        );

      case Routes.createPassword:
        return buildPlatformPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<CreatePasswordCubit>(),
            child: const CreatePasswordScreen(),
          ),
        );

      case Routes.layout:
        return buildPlatformPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<LayoutCubit>(),
            child: const LayoutScreen(),
          ),
        );

      case Routes.exercises:
        return buildPlatformPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<ExercisesCubit>()..loadExercises(),
            child: const ExercisesScreen(),
          ),
        );

      case Routes.games:
        return buildPlatformPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => getIt<GamesCubit>()..loadGames(),
            child: const GamesScreen(),
          ),
        );

      default:
        return buildPlatformPageRoute(
          settings: settings,
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}