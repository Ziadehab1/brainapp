import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../cubits/create_password_cubit/create_password_cubit.dart';
import '../../cubits/create_password_cubit/create_password_state.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePasswordCubit, CreatePasswordState>(
      listener: (context, state) {
        if (state.status == RequestStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    state.failure?.message ?? 'Password creation failed')),
          );
        }
      },
      child: const Scaffold(
        body: Center(child: Text('Create Password Screen')),
      ),
    );
  }
}