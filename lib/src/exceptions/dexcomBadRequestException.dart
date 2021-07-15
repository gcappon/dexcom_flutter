import 'package:dexcom_flutter/src/exceptions/dexcomException.dart';

/// [DexcomBadRequestException] is a class that implements the
/// [DexcomExceptionType.BAD_REQUEST] exception.
class DexcomBadRequestException extends DexcomException {
  /// Default [DexcomBadRequestException] constructor.
  DexcomBadRequestException({
    required String message,
  }) : super(type: DexcomExceptionType.BAD_REQUEST, message: message);

  @override
  String toString() {
    return 'DexcomBadRequestException [$type]: $message';
  } // toString
} // DexcomBadRequestException
