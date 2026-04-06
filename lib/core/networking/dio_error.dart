/// A class that handles Dio errors and converts them into custom [Failure] objects.
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../shared/constants/response_code.dart';
import '../../shared/constants/response_message.dart';
import '../../shared/snackbar_alerts/snack_alert.dart';
import '../analytics/debug_analytics.dart';
import '../injection/injection.dart';
import '../model/error/failure.dart';
import '../routes/app_router.dart';
import '../routes/app_router.gr.dart';

/// A class that handles Dio errors and converts them into custom [Failure] objects.
@injectable
class DioErrorHandler implements Exception {
  /// An instance of [DebugAnalytics] for logging errors.
  final DebugAnalytics _analytics;

  /// Creates a new instance of [DioErrorHandler].
  const DioErrorHandler(this._analytics);

  /// Handles an error and converts it to a [Failure] object.
  ///
  /// If the error is a [DioException], it is handled by [_handleError].
  /// Otherwise, it is logged and a [CustomFailure] is returned.
  Future<Failure> handleError(dynamic error, StackTrace stackTrace, [String? message]) async {
    late Failure failure;

    if (error is DioException) {
      failure = await _handleError(error);
    } else {
      _analytics.errorLog(s: stackTrace, e: error);
      failure = const CustomFailure();
    }

    return failure;
  }

  /// Handles a [DioException] and returns a specific [Failure] based on the error type.
  Future<Failure> _handleError(DioException dioError) async {
    _analytics.errorLog(name: 'Dio Error', s: dioError.stackTrace, e: dioError.error);

    switch (dioError.type) {
      case DioExceptionType.cancel:
        return const UnexpectedFailure(message: 'Request to API server was cancelled');

      case DioExceptionType.connectionError:
        return const NetworkFailure(message: 'No Internet');

      case DioExceptionType.badCertificate:
        return const UnexpectedFailure(message: 'Bad Certificate');

      case DioExceptionType.connectionTimeout:
        return const TimeoutFailure(message: 'Connection timeout with API server');

      case DioExceptionType.sendTimeout:
        return const TimeoutFailure(message: 'Send timeout in connection with API server');

      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure(message: 'Receive timeout in connection with API server');

      case DioExceptionType.badResponse:
        return _handleResponseError(dioError.response!);

      case DioExceptionType.unknown:
        if (dioError.error is SocketException) {
          return const SocketFailure(message: 'Network connection failed');
        }

        if (dioError.error is FormatException) {
          return const ParsingFailure(message: 'JSON parsing error');
        }
        return const UnexpectedFailure(message: 'Unexpected error occurred');
    }
  }

  /// Handles a [Response] with an error status code and returns a specific [Failure].
  Future<Failure> _handleResponseError(Response response) async {
    final Map data = response.data as Map;
    final message = data['message'] as String?;
    switch (response.statusCode) {
      case ResponseCode.badRequestCode:
        return ValidationFailure(
          message: message ?? ResponseMessage.badRequestMessage,
          statusCode: ResponseCode.badRequestCode,
        );
      case ResponseCode.unauthorizedRequestCode:
        // await locator<ProfileRepository>().logout();
        unawaited(locator<SnackBarAlert>().showToast(message: ResponseMessage.unauthorizedRequestMessage));
        await locator<AppRouter>().replaceAll([const LoginRoute()]);
        return AuthenticationFailure(
          message: message ?? ResponseMessage.unauthorizedRequestMessage,
          statusCode: ResponseCode.unauthorizedRequestCode,
        );
      case ResponseCode.forbiddenRequestCode:
        return PermissionFailure(
          message: message ?? ResponseMessage.forbiddenRequestMessage,
          statusCode: ResponseCode.forbiddenRequestCode,
        );
      case ResponseCode.resourceNotFoundCode:
        return NotFoundFailure(
          message: message ?? ResponseMessage.resourceNotFoundMessage,
          statusCode: ResponseCode.resourceNotFoundCode,
        );
      case ResponseCode.requestTimeoutCode:
        return TimeoutFailure(
          message: message ?? ResponseMessage.requestTimeoutMessage,
          statusCode: ResponseCode.requestTimeoutCode,
        );
      case ResponseCode.conflictOccurredCode:
        return const ConflictFailure(
          message: ResponseMessage.conflictOccurredMessage,
          statusCode: ResponseCode.conflictOccurredCode,
        );
      case ResponseCode.tooManyRequestsCode:
        return RateLimitFailure(
          message: message ?? ResponseMessage.tooManyRequestsMessage,
          statusCode: ResponseCode.tooManyRequestsCode,
        );
      case ResponseCode.internalServerErrorCode:
        return const ServerFailure(
          message: ResponseMessage.internalServerErrorMessage,
          statusCode: ResponseCode.internalServerErrorCode,
        );
      case ResponseCode.serviceUnavailableCode:
        return ServerFailure(
          message: message ?? ResponseMessage.serviceUnavailableMessage,
          statusCode: ResponseCode.serviceUnavailableCode,
        );
      default:
        return ServerFailure(
          message: message ?? 'Received invalid status code: \${response.statusCode}',
          statusCode: response.statusCode,
        );
    }
  }
}
