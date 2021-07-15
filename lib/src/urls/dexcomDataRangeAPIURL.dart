import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

/// [DexcomDataRangeAPIURL] is a class that expresses multiple factory
/// constructors to be used to generate Dexcom Web APIs urls to fetch
/// [DexcomDataRangeData].
class DexcomDataRangeAPIURL extends DexcomAPIURL {

  /// Default [DexcomDataRangeAPIURL] constructor.
  DexcomDataRangeAPIURL({required bool isSandbox}) : super(url : '', isSandbox : isSandbox){
    this.url = '${_getBaseURL(isSandbox)}';
  } // DexcomDataRangeAPIURL
  
  /// A private method that generates the base url of a [DexcomDataRangeAPIURL].
  static String _getBaseURL(bool sandbox) {
    return sandbox
        ? 'https://sandbox-api.dexcom.com/v2/users/self/dataRange'
        : 'https://api.dexcom.com/v2/users/self/dataRange';
  } // _getBaseURL

} // DexcomDataRangeAPIURL
