import 'package:equatable/equatable.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../../../core/services/error/failure.dart';
import '../../models/responses/auth_response.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = RequestStatus.initial,
    this.response,
    this.failure,
  });

  final RequestStatus status;
  final AuthResponse? response;
  final Failure? failure;

  LoginState copyWith({
    RequestStatus? status,
    AuthResponse? response,
    Failure? failure,
  }) =>
      LoginState(
        status: status ?? this.status,
        response: response ?? this.response,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [status, response, failure];
}