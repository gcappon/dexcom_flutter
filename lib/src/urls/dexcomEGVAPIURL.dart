import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

import 'package:dexcom_flutter/src/utils/formats.dart';

/// [DexcomEGVAPIURL] is a class that expresses multiple factory
/// constructors to be used to generate Dexcom Web APIs urls to fetch
/// [DexcomEGVData].
class DexcomEGVAPIURL extends DexcomAPIURL {
  /// Default [DexcomEGVAPIURL] constructor.
  DexcomEGVAPIURL({required String url, required bool isSandbox}) : super(url : url, isSandbox : isSandbox);

  /// Generates a [DexcomEGVAPIURL] to get [DexcomEGVData] from a specific
  /// [startDate] to a specific [endDate].
  factory DexcomEGVAPIURL.range({required DateTime startDate, required DateTime endDate, required bool isSandbox}) {
    String startDateStr = Formats.fullDateFormat.format(startDate);
    String endDateStr = Formats.fullDateFormat.format(endDate);
    return DexcomEGVAPIURL(
      url: '${_getBaseURL(isSandbox)}startDate=$startDateStr&endDate=$endDateStr',
      isSandbox: isSandbox
    );
  } // DexcomEGVAPIURL.range

  /// A private method that generates the base url of a [DexcomEGVAPIURL].
  static String _getBaseURL(bool isSandbox) {
    return isSandbox
        ? 'https://sandbox-api.dexcom.com/v2/users/self/egvs?'
        : 'https://api.dexcom.com/v2/users/self/egvs?';
  } // _getBaseURL

} // DexcomEGVAPIURL
