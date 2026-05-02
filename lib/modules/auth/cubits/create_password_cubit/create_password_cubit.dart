import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../models/requests/create_password_request.dart';
import '../../repositories/auth_repository.dart';
import 'create_password_state.dart';

class CreatePasswordCubit extends Cubit<CreatePasswordState> {
  CreatePasswordCubit(this._repository) : super(const CreatePasswordState());

  final AuthRepository _repository;

  Future<void> createPassword({
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final result = await _repository.createPassword(
      CreatePasswordRequest(
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
    );
    result.fold(
      (failure) => emit(
          state.copyWith(status: RequestStatus.failure, failure: failure)),
      (_) => emit(state.copyWith(status: RequestStatus.success)),
    );
  }
}