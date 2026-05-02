import 'package:dartz/dartz.dart';

import '../../../core/base/repositories/base_repository.dart';
import '../../../core/services/error/failure.dart';
import '../../../core/services/network/api_client.dart';
import '../../../core/services/network/endpoints.dart';
import '../models/requests/create_password_request.dart';
import '../models/requests/login_request.dart';
import '../models/requests/otp_request.dart';
import '../models/responses/auth_response.dart';

class AuthRepository extends BaseRepository {
  const AuthRepository({
    required this.apiClient,
    required super.networkInfo,
    required super.errorHandler,
  });

  final ApiClient apiClient;

  Future<Either<Failure, AuthResponse>> login(LoginRequest request) =>
      call(() async {
        final data = await apiClient.post(Endpoints.login, data: request.toJson());
        return AuthResponse.fromJson(data as Map<String, dynamic>);
      });

  Future<Either<Failure, void>> verifyOtp(OtpRequest request) =>
      call(() async {
        await apiClient.post(Endpoints.verifyOtp, data: request.toJson());
      });

  Future<Either<Failure, void>> createPassword(
          CreatePasswordRequest request) =>
      call(() async {
        await apiClient.post(Endpoints.createPassword,
            data: request.toJson());
      });
}