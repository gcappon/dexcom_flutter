import 'package:logger/logger.dart';

import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

import 'package:dexcom_flutter/src/data/dexcomEventData.dart';

import 'package:dexcom_flutter/src/managers/dexcomDataManager.dart';

/// [DexcomEventDataManager] is a class the manages the requests related to
/// [DexcomEventData].
class DexcomEventDataManager extends DexcomDataManager {
  DexcomEventDataManager({String? clientID, String? clientSecret})
      : super(clientID: clientID, clientSecret: clientSecret);

  @override
  Future<List<DexcomEventData>> fetch(DexcomAPIURL dexcomUrl) async {
    // Get the response
    final response = await getResponse(dexcomUrl);

    // Debugging
    final logger = Logger();
    logger.i('$response');

    //Extract data and return them
    List<DexcomEventData> eventDataPoints =
        _extractDexcomEventData(response);
    return eventDataPoints;
  } // fetch

  /// A private method that extracts [DexcomEventData] from the given response.
  List<DexcomEventData> _extractDexcomEventData(
      dynamic response) {
    final nRecords = response["events"].length;
    List<DexcomEventData> eventDataPoints =
        List<DexcomEventData>.empty(growable: true);
    for (var record = 0; record < nRecords; record++) {
      eventDataPoints.add(DexcomEventData.fromJson(json: response["events"][record]));
    } // for entry
    return eventDataPoints;
  } // _extractDexcomEventData

} // DexcomEventDataManager
