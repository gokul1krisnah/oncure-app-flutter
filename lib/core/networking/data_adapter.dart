import 'package:fpdart/fpdart.dart';
import 'package:retrofit/call_adapter.dart';

import '../injection/injection.dart';
import '../model/error/failure.dart';
import '../networking/dio_error.dart';

/// A custom Retrofit [CallAdapter] to integrate functional error handling using `fpdart`.
///
/// This adapter is the cornerstone of the application's error handling strategy.
/// It intercepts the results of API calls and wraps them in an [Either] type,
/// which explicitly represents either a success (`Right<T>`) or a failure (`Left<Failure>`).
///
/// This approach forces the calling code (typically in a repository) to handle
/// both success and error states, preventing unhandled exceptions and making
/// the data flow more predictable.
class DataAdapter<T> extends CallAdapter<Future<T>, Future<Either<Failure, T>>> {
  /// Adapts the network call by executing it and wrapping the result in an [Either].
  ///
  /// It invokes the provided `call` function, which represents the actual network
  /// request.
  /// - If the call succeeds, it returns `Either.right(response)`.
  /// - If the call throws an exception, it catches the error, uses the [DioErrorHandler]
  ///   to convert it into a standardized [Failure] object, and returns `Either.left(error)`.
  @override
  Future<Either<Failure, T>> adapt(Future<T> Function() call) async {
    try {
      final T response = await call();

      return Either.right(response);
    } catch (failure, s) {
      // The locator retrieves the DioErrorHandler to process the raw error.
      final error = await locator<DioErrorHandler>().handleError(failure, s);
      return Either.left(error);
    }
  }
}
