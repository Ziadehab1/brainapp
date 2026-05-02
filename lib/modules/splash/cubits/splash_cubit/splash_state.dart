import 'package:equatable/equatable.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../../../core/services/error/failure.dart';

class SplashState extends Equatable {
  const SplashState({
    this.status = RequestStatus.initial,
    this.isAuthenticated = false,
    this.failure,
  });

  final RequestStatus status;
  final bool isAuthenticated;
  final Failure? failure;

  SplashState copyWith({
    RequestStatus? status,
    bool? isAuthenticated,
    Failure? failure,
  }) =>
      SplashState(
        status: status ?? this.status,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [status, isAuthenticated, failure];
}