import 'package:brainflow/core/l10n/app_localizations.dart';
import 'package:brainflow/core/l10n/locale_controller.dart';
import 'package:brainflow/features/onboarding_screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleController.load();
  runApp(const BrainApp());
}

class BrainApp extends StatefulWidget {
  const BrainApp({super.key});

  @override
  State<BrainApp> createState() => _BrainAppState();
}

class _BrainAppState extends State<BrainApp> {
  @override
  void initState() {
    super.initState();
    LocaleController.locale.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    LocaleController.locale.removeListener(() => setState(() {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: LocaleController.locale.value,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashScreen(),
    );
  }
}
