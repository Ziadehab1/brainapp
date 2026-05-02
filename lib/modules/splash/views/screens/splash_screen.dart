import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/navigation/navigation_service.dart';
import '../../../../config/navigation/routes.dart';
import '../../../../core/base/enums/request_status.dart';
import '../../cubits/splash_cubit/splash_cubit.dart';
import '../../cubits/splash_cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.status == RequestStatus.success) {
          NavigationService.pushNamedAndRemoveUntil(
            state.isAuthenticated ? Routes.layout : Routes.login,
          );
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}