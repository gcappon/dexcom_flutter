import 'package:logger/logger.dart';

import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

import 'package:dexcom_flutter/src/data/dexcomCalibrationData.dart';

import 'package:dexcom_flutter/src/managers/dexcomDataManager.dart';

/// [DexcomCalibrationDataManager] is a class the manages the requests related to
/// [DexcomCalibrationData].
class DexcomCalibrationDataManager extends DexcomDataManager {
  DexcomCalibrationDataManager({String? clientID, String? clientSecret})
      : super(clientID: clientID, clientSecret: clientSecret);

  @override
  Future<List<DexcomCalibrationData>> fetch(DexcomAPIURL dexcomUrl) async {
    // Get the response
    final response = await getResponse(dexcomUrl);

    // Debugging
    final logger = Logger();
    logger.i('$response');

    //Extract data and return them
    List<DexcomCalibrationData> calibrationDataPoints =
        _extractDexcomCalibrationData(response);
    return calibrationDataPoints;
  } // fetch

  /// A private method that extracts [DexcomCalibrationData] from the given response.
  List<DexcomCalibrationData> _extractDexcomCalibrationData(
      dynamic response) {
    final nRecords = response["calibrations"].length;
    List<DexcomCalibrationData> calibrationDataPoints =
        List<DexcomCalibrationData>.empty(growable: true);
    for (var record = 0; record < nRecords; record++) {
      calibrationDataPoints.add(DexcomCalibrationData.fromJson(json: response["calibrations"][record]));
    } // for entry
    return calibrationDataPoints;
  } // _extractDexcomCalibrationData

} // DexcomCalibrationDataManager
