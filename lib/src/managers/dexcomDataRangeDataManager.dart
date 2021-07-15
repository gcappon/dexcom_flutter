import 'package:logger/logger.dart';

import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

import 'package:dexcom_flutter/src/data/dexcomDataRangeData.dart';

import 'package:dexcom_flutter/src/managers/dexcomDataManager.dart';

/// [DexcomDataRangeDataManager] is a class the manages the requests related to
/// [DexcomDataRangeData].
class DexcomDataRangeDataManager extends DexcomDataManager {
  DexcomDataRangeDataManager({String? clientID, String? clientSecret})
      : super(clientID: clientID, clientSecret: clientSecret);

  @override
  Future<List<DexcomDataRangeData>> fetch(DexcomAPIURL dexcomUrl) async {
    // Get the response
    final response = await getResponse(dexcomUrl);

    // Debugging
    final logger = Logger();
    logger.i('$response');

    //Extract data and return them
    List<DexcomDataRangeData> dataRangeDataPoints =
        _extractDexcomDataRangeData(response);
    return dataRangeDataPoints;
  } // fetch

  /// A private method that extracts [DexcomDataRangeData] from the given response.
  List<DexcomDataRangeData> _extractDexcomDataRangeData(
      dynamic response) {
    List<DexcomDataRangeData> dataRangeDataPoints =
        List<DexcomDataRangeData>.empty(growable: true);
    dataRangeDataPoints.add(DexcomDataRangeData.fromJson(json: response));
    return dataRangeDataPoints;
  } // _extractDexcomDataRangeData

} // DexcomDataRangeDataManager
