import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../models/requests/login_request.dart';
import '../../repositories/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repository) : super(const LoginState());

  final AuthRepository _repository;

  Future<void> login({required String phone, required String password}) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final result = await _repository.login(
      LoginRequest(phone: phone, password: password),
    );
    result.fold(
      (failure) => emit(state.copyWith(
          status: RequestStatus.failure, failure: failure)),
      (response) => emit(state.copyWith(
          status: RequestStatus.success, response: response)),
    );
  }
}