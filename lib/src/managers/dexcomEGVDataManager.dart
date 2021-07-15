import 'package:logger/logger.dart';

import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

import 'package:dexcom_flutter/src/data/dexcomEGVData.dart';

import 'package:dexcom_flutter/src/managers/dexcomDataManager.dart';

/// [DexcomEGVDataManager] is a class the manages the requests related to
/// [DexcomEGVData].
class DexcomEGVDataManager extends DexcomDataManager {
  DexcomEGVDataManager({String? clientID, String? clientSecret})
      : super(clientID: clientID, clientSecret: clientSecret);

  @override
  Future<List<DexcomEGVData>> fetch(DexcomAPIURL dexcomUrl) async {
    // Get the response
    final response = await getResponse(dexcomUrl);

    // Debugging
    final logger = Logger();
    logger.i('$response');

    //Extract data and return them
    List<DexcomEGVData> egvDataPoints =
        _extractDexcomEGVData(response);
    return egvDataPoints;
  } // fetch

  /// A private method that extracts [DexcomEGVData] from the given response.
  List<DexcomEGVData> _extractDexcomEGVData(
      dynamic response) {
    final nRecords = response["egvs"].length;
    List<DexcomEGVData> egvDataPoints =
        List<DexcomEGVData>.empty(growable: true);
    for (var record = 0; record < nRecords; record++) {
      egvDataPoints.add(DexcomEGVData.fromJsonWithUnits(
        unit: response["unit"],
        rateUnit: response["rateUnit"],
        json: response["egvs"][record]));
    } // for entry
    return egvDataPoints;
  } // _extractDexcomEGVData

} // DexcomEGVDataManager
