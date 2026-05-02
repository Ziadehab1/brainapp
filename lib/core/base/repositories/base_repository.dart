import 'package:dartz/dartz.dart';

import '../../services/error/error_handler.dart';
import '../../services/error/failure.dart';
import '../../services/network/network_info.dart';

abstract class BaseRepository {
  const BaseRepository({
    required this.networkInfo,
    required this.errorHandler,
  });

  final NetworkInfo networkInfo;
  final ErrorHandler errorHandler;

  Future<Either<Failure, T>> call<T>(Future<T> Function() request) async {
    if (!await networkInfo.isConnected) {
      return const Left(Failure.network);
    }
    try {
      final result = await request();
      return Right(result);
    } catch (e) {
      return Left(errorHandler.handle(e));
    }
  }
}