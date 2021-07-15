/// An enumerator defining the possible types of [DexcomException].
enum DexcomExceptionType {

  /// Code = 302. The requested resource resides under a different URL (used in redirect for authentication purposes).
  FOUND,

  /// Code = 404. It occurs when the Dexcom API resource is not found
  NOT_FOUND,

  ///Code = 400. It occurs when the request URL is bad formatted (it should never happen).
  BAD_REQUEST,

  /// Code = 401. When the requester has no permissions to resolve the request.
  UNAUTHORIZED,

  /// Code = 429. When the request rate limit is exceeded.
  TOO_MANY_REQUESTS,

  /// Code = 500. When the server encountered an unexpected condition which prevented it from fulfilling the request.
  INTERNAL_SERVER_ERROR,

  /// Code = Any. Default error type.
  DEFAULT,

} // DexcomExceptionType

/// [DexcomException] is an abstract class defining an [Exception] that
/// can be thrown by dexcom_flutter.
abstract class DexcomException implements Exception {
  /// The [DexcomException] method.
  String message;

  /// The type of the [DexcomException].
  DexcomExceptionType type;

  /// Default [DexcomException] constructor.
  DexcomException({this.message = '', this.type = DexcomExceptionType.DEFAULT});

  /// Returns the string representation of this object.
  String toString();
} // DexcomException
