import 'package:dexcom_flutter/src/exceptions/dexcomException.dart';

/// [DexcomTooManyRequestsException] is a class that implements the
/// [DexcomExceptionType.TOO_MANY_REQUESTS] exception.
class DexcomTooManyRequestsException extends DexcomException {
  /// Default [FitbitRateLimitExceededException] constructor.
  DexcomTooManyRequestsException({
    required String message,
  }) : super(type: DexcomExceptionType.TOO_MANY_REQUESTS, message: message);

  @override
  String toString() {
    return 'DexcomTooManyRequestsException [$type]: $message';
  } // toString
} // DexcomTooManyRequestsException
