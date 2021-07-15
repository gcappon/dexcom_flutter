import 'package:dexcom_flutter/src/exceptions/dexcomException.dart';

/// [DexcomInternalServerErrorException] is a class that implements the
/// [DexcomExceptionType.INTERNAL_SERVER_ERROR] exception.
class DexcomInternalServerErrorException extends DexcomException {
  /// Default [DexcomInternalServerErrorException] constructor.
  DexcomInternalServerErrorException({
    required String message,
  }) : super(
            type: DexcomExceptionType.INTERNAL_SERVER_ERROR,
            message: message);

  @override
  String toString() {
    return 'DexcomInternalServerErrorException [$type]: $message';
  } // toString
} // DexcomInternalServerErrorException
