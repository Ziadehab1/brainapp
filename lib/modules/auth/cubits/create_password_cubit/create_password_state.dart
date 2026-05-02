import 'package:equatable/equatable.dart';

import '../../../../core/base/enums/request_status.dart';
import '../../../../core/services/error/failure.dart';

class CreatePasswordState extends Equatable {
  const CreatePasswordState({
    this.status = RequestStatus.initial,
    this.failure,
  });

  final RequestStatus status;
  final Failure? failure;

  CreatePasswordState copyWith({
    RequestStatus? status,
    Failure? failure,
  }) =>
      CreatePasswordState(
        status: status ?? this.status,
        failure: failure ?? this.failure,
      );

  @override
  List<Object?> get props => [status, failure];
}