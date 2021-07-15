import 'package:dexcom_flutter/src/data/statisticsRequest.dart';
import 'package:dexcom_flutter/src/utils/formats.dart';

import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

/// [DexcomStatisticsAPIURL] is a class that expresses multiple factory
/// constructors to be used to generate Dexcom Web APIs urls to fetch
/// [DexcomStatisticsData].
class DexcomStatisticsAPIURL extends DexcomAPIURL {
  /// The data to be attached to the url.
  late StatisticsRequest statisticsRequest;
  
  /// Default [DexcomStatisticsAPIURL] constructor.
  DexcomStatisticsAPIURL({required String url, required bool isSandbox, required StatisticsRequest statisticsRequest}) : super(url : url, isSandbox : isSandbox){

    // DexcomStatisticsAPIURL fields
    this.statisticsRequest = statisticsRequest;

  } // DexcomStatisticsAPIURL

  /// Factory constructor that generates a [DexcomAuthAPIURL] to be used
  /// to get the access and refresh tokens.
  factory DexcomStatisticsAPIURL.range({required DateTime startDate, required DateTime endDate, required StatisticsRequest statisticsRequest, required bool isSandbox}) {

    String startDateStr = Formats.fullDateFormat.format(startDate);
    String endDateStr = Formats.fullDateFormat.format(endDate);
    
    return DexcomStatisticsAPIURL(
      url: '${_getBaseURL(isSandbox)}startDate=$startDateStr&endDate=$endDateStr',
      isSandbox: isSandbox,
      statisticsRequest: statisticsRequest,
    );
  } // DexcomStatisticsAPIURL.range

  /// A private method that generates the base url of a [DexcomStatisticsAPIURL].
  static String _getBaseURL(bool isSandbox) {
    return isSandbox
        ? 'https://sandbox-api.dexcom.com/v2/users/self/statistics?'
        : 'https://api.dexcom.com/v2/users/self/statistics?';
  } // _getBaseURL

} // DexcomStatisticsAPIURL
