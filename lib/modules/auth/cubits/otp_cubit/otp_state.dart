import 'package:equatable/equatable.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../../../core/services/error/failure.dart';

class OtpState extends Equatable {
  const OtpState({
    this.status = RequestStatus.initial,
    this.failure,
  });

  final RequestStatus status;
  final Failure? failure;

  OtpState copyWith({RequestStatus? status, Failure? failure}) => OtpState(
        status: status ?? this.status,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [status, failure];
}