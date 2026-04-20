import 'package:brainapp/features/onboarding_screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BrainApp());
}

class BrainApp extends StatelessWidget {
  const BrainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, 
    home: SplashScreen());
  }
}
