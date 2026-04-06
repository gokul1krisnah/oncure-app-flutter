import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
abstract class Failure with _$Failure {

  /// Represents failures related to no internet connection.
  const factory Failure.socketFailure({
    required String message,
    int? statusCode,
  }) = SocketFailure;

  /// Represents failures related to database operations.
  const factory Failure.databaseFailure({
    String? message,
    int? statusCode,
  }) = DatabaseFailure;

  /// Represents failures related to network operations, such as connectivity issues.
  /// (e.g., certificate issues).
  const factory Failure.networkFailure({
    required String message,
    int? statusCode,
  }) = NetworkFailure;

  /// Represents failures related to data parsing, such as JSON parsing errors.
  const factory Failure.parsingFailure({
    required String message,
    int? statusCode,
  }) = ParsingFailure;

  /// Represents failures related to input validation, such as invalid user input.
  const factory Failure.validationFailure({
    required String message,
    required int statusCode,
  }) = ValidationFailure;

  /// Represents custom failures.
  const factory Failure.customFailure({String? message, int? statusCode}) =
      CustomFailure;

  /// Represents unexpected failures that do not fit any other category.
  const factory Failure.unexpectedFailure({String? message, int? statusCode}) =
      UnexpectedFailure;

  /// Represents failures related to user authentication, such as invalid credentials.
  /// (e.g., 401 for unauthorized).
  const factory Failure.authenticationFailure({
    required String message,
    required int statusCode,
  }) = AuthenticationFailure;

  /// Represents failures related to permissions, such as access denied.
  /// (e.g., 403 for forbidden).
  const factory Failure.permissionFailure({
    required String message,
    required int statusCode,
  }) = PermissionFailure;

  /// Represents failures related to resource not found, such as a missing endpoint.
  /// (e.g., 404 for not found).
  const factory Failure.notFoundFailure({
    required String message,
    required int statusCode,
  }) = NotFoundFailure;

  /// Represents failures related to timeouts, such as request timeouts.
  /// (e.g., 408 for request timeout).
  const factory Failure.timeoutFailure({
    required String message,
    int? statusCode,
  }) = TimeoutFailure;

  /// Represents failures related to conflicts, such as data conflicts.
  /// (e.g., 409 for conflict).
  const factory Failure.conflictFailure({
    required String message,
    required int statusCode,
  }) = ConflictFailure;

  /// Represents failures related to rate limiting, such as too many requests.
  /// (e.g., 429 for too many requests).
  const factory Failure.rateLimitFailure({
    required String message,
    required int statusCode,
  }) = RateLimitFailure;

  /// Represents failures that occur on the server side, like internal server errors.
  /// (e.g., >= 500 for internal server error).
  const factory Failure.serverFailure({
    required String message,
    int? statusCode,
  }) = ServerFailure;
}

