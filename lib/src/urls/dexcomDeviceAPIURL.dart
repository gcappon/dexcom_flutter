import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

import 'package:dexcom_flutter/src/utils/formats.dart';

/// [DexcomDeviceAPIURL] is a class that expresses multiple factory
/// constructors to be used to generate Dexcom Web APIs urls to fetch
/// [DexcomDeviceData].
class DexcomDeviceAPIURL extends DexcomAPIURL {
  /// Default [DexcomDeviceAPIURL] constructor.
  DexcomDeviceAPIURL({required String url, required bool isSandbox}) : super(url : url, isSandbox : isSandbox);

  /// Generates a [DexcomDeviceAPIURL] to get [DexcomDeviceData] from a specific
  /// [startDate] to a specific [endDate].
  factory DexcomDeviceAPIURL.range({required DateTime startDate, required DateTime endDate, required bool isSandbox}) {
    String startDateStr = Formats.fullDateFormat.format(startDate);
    String endDateStr = Formats.fullDateFormat.format(endDate);
    return DexcomDeviceAPIURL(
      url: '${_getBaseURL(isSandbox)}startDate=$startDateStr&endDate=$endDateStr',
      isSandbox: isSandbox
    );
  } // DexcomDeviceAPIURL.range

  /// A private method that generates the base url of a [DexcomDeviceAPIURL].
  static String _getBaseURL(bool isSandbox) {
    return isSandbox
        ? 'https://sandbox-api.dexcom.com/v2/users/self/devices?'
        : 'https://api.dexcom.com/v2/users/self/devices?';
  } // _getBaseURL

} // DexcomDeviceAPIURL
