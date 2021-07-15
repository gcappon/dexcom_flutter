import 'package:dexcom_flutter/src/exceptions/dexcomException.dart';

/// [DexcomFoundException] is a class that implements the
/// [DexcomExceptionType.FOUND] exception.
class DexcomFoundException extends DexcomException {
  /// Default [DexcomFoundException] constructor.
  DexcomFoundException({
    required String message,
  }) : super(type: DexcomExceptionType.FOUND, message: message);

  @override
  String toString() {
    return 'DexcomFoundException [$type]: $message';
  } // toString
} // DexcomFoundException
