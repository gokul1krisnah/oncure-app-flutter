import '../../core/model/error/failure.dart';

extension FailureExtension on Failure {
  void exceptionHandler({
    Function(String? message)? onDioException,
    Function()? onOtherException,
  }) {
    if (this is! CustomFailure) {
      onDioException?.call(message);
    } else {
      onOtherException?.call();
    }
  }
}
