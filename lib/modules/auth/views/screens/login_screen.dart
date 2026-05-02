import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../cubits/login_cubit/login_cubit.dart';
import '../../cubits/login_cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == RequestStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failure?.message ?? 'Login failed')),
          );
        }
      },
      child: const Scaffold(
        body: Center(child: Text('Login Screen')),
      ),
    );
  }
}