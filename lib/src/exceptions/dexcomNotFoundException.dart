import 'package:dexcom_flutter/src/exceptions/dexcomException.dart';

/// [DexcomNotFoundException] is a class that implements the
/// [DexcomExceptionType.NOT_FOUND] exception.
class DexcomNotFoundException extends DexcomException {
  /// Default [DexcomNotFoundException] constructor.
  DexcomNotFoundException({
    required String message,
  }) : super(type: DexcomExceptionType.NOT_FOUND, message: message);

  @override
  String toString() {
    return 'DexcomNotFoundException [$type]: $message';
  } // toString
} // DexcomNotFoundException
