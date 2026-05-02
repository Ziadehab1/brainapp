import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'config/localization/cubit/l10n_cubit.dart';
import 'config/localization/cubit/l10n_state.dart';
import 'config/navigation/navigation_service.dart';
import 'config/navigation/route_generator.dart';
import 'config/navigation/routes.dart';
import 'core/l10n/app_localizations.dart';
import 'di_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  await SentryFlutter.init(
    (options) {
      options.dsn = '';
      options.tracesSampleRate = 1.0;
      options.environment = 'development';
    },
    appRunner: () => runApp(const BrainApp()),
  );
}

class BrainApp extends StatelessWidget {
  const BrainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<L10nCubit>()..loadSavedLocale(),
        ),
      ],
      child: BlocBuilder<L10nCubit, L10nState>(
        builder: (context, localeState) {
          return MaterialApp(
            title: 'Brain Flow',
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: Routes.splash,
            locale: localeState.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          );
        },
      ),
    );
  }
}
