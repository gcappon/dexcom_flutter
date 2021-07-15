import 'package:logger/logger.dart';

import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

import 'package:dexcom_flutter/src/data/dexcomDeviceData.dart';

import 'package:dexcom_flutter/src/managers/dexcomDataManager.dart';

/// [DexcomDeviceDataManager] is a class the manages the requests related to
/// [DexcomDeviceData].
class DexcomDeviceDataManager extends DexcomDataManager {
  DexcomDeviceDataManager({String? clientID, String? clientSecret})
      : super(clientID: clientID, clientSecret: clientSecret);

  @override
  Future<List<DexcomDeviceData>> fetch(DexcomAPIURL dexcomUrl) async {
    // Get the response
    final response = await getResponse(dexcomUrl);

    // Debugging
    final logger = Logger();
    logger.i('$response');

    //Extract data and return them
    List<DexcomDeviceData> deviceDataPoints =
        _extractDexcomDeviceData(response);
    return deviceDataPoints;
  } // fetch

  /// A private method that extracts [DexcomDeviceData] from the given response.
  List<DexcomDeviceData> _extractDexcomDeviceData(
      dynamic response) {
    final nRecords = response["devices"].length;
    List<DexcomDeviceData> deviceDataPoints =
        List<DexcomDeviceData>.empty(growable: true);
    for (var record = 0; record < nRecords; record++) {
      deviceDataPoints.add(DexcomDeviceData.fromJson(json: response["devices"][record]));
    } // for entry
    return deviceDataPoints;
  } // _extractDexcomDeviceData

} // DexcomDeviceDataManager
