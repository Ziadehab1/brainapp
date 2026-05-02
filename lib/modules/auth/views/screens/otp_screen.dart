import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../cubits/otp_cubit/otp_cubit.dart';
import '../../cubits/otp_cubit/otp_state.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state.status == RequestStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.failure?.message ?? 'OTP verification failed')),
          );
        }
      },
      child: const Scaffold(
        body: Center(child: Text('OTP Screen')),
      ),
    );
  }
}