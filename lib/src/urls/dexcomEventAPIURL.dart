import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

import 'package:dexcom_flutter/src/utils/formats.dart';

/// [DexcomEventAPIURL] is a class that expresses multiple factory
/// constructors to be used to generate Dexcom Web APIs urls to fetch
/// [DexcomEventData].
class DexcomEventAPIURL extends DexcomAPIURL {
  /// Default [DexcomEventAPIURL] constructor.
  DexcomEventAPIURL({required String url, required bool isSandbox}) : super(url : url, isSandbox : isSandbox);

  /// Generates a [DexcomEventAPIURL] to get [DexcomEventData] from a specific
  /// [startDate] to a specific [endDate].
  factory DexcomEventAPIURL.range({required DateTime startDate, required DateTime endDate, required bool isSandbox}) {
    String startDateStr = Formats.fullDateFormat.format(startDate);
    String endDateStr = Formats.fullDateFormat.format(endDate);
    return DexcomEventAPIURL(
      url: '${_getBaseURL(isSandbox)}startDate=$startDateStr&endDate=$endDateStr',
      isSandbox: isSandbox
    );
  } // DexcomEventAPIURL.range

  /// A private method that generates the base url of a [DexcomEventAPIURL].
  static String _getBaseURL(bool isSandbox) {
    return isSandbox
        ? 'https://sandbox-api.dexcom.com/v2/users/self/events?'
        : 'https://api.dexcom.com/v2/users/self/events?';
  } // _getBaseURL

} // DexcomEventAPIURL
