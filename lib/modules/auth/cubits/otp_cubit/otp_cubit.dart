import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../models/requests/otp_request.dart';
import '../../repositories/auth_repository.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._repository) : super(const OtpState());

  final AuthRepository _repository;

  Future<void> verifyOtp({required String phone, required String otp}) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final result = await _repository.verifyOtp(
      OtpRequest(phone: phone, otp: otp),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(status: RequestStatus.failure, failure: failure)),
      (_) => emit(state.copyWith(status: RequestStatus.success)),
    );
  }
}