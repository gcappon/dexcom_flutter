import 'package:dexcom_flutter/src/exceptions/dexcomException.dart';

/// [DexcomUnauthorizedException] is a class that implements the
/// [DexcomExceptionType.UNAUTHORIZED] exception.
class DexcomUnauthorizedException extends DexcomException {
  /// Default [DexcomUnauthorizedException] constructor.
  DexcomUnauthorizedException({
    required String message,
  }) : super(type: DexcomExceptionType.UNAUTHORIZED, message: message);

  @override
  String toString() {
    return 'DexcomUnauthorizedException [$type]: $message';
  } // toString
} // DexcomUnauthorizedException
