import 'package:dexcom_flutter/src/data/dexcomStatisticsData.dart';
import 'package:dexcom_flutter/src/dexcomConnector.dart';
import 'package:dexcom_flutter/src/urls/dexcomStatisticsAPIURL.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

import 'package:dexcom_flutter/src/managers/dexcomDataManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [DexcomStatisticsDataManager] is a class the manages the requests related to
/// [DexcomStatisticsData].
class DexcomStatisticsDataManager extends DexcomDataManager {
  DexcomStatisticsDataManager({String? clientID, String? clientSecret})
      : super(clientID: clientID, clientSecret: clientSecret);

  @override
  Future<List<DexcomStatisticsData>> fetch(DexcomAPIURL dexcomUrl) async {

    // Refresh token if needed
    if(DexcomConnector.tokenNeedRefresh()){
      await DexcomConnector.refreshToken(clientID: clientID!, clientSecret: clientSecret!, isSandbox: dexcomUrl.isSandbox);
    }//if

    // Cast the url
    DexcomStatisticsAPIURL dexcomStatisticsAPIURL = dexcomUrl as DexcomStatisticsAPIURL;

    // Instantiate Dio
    Dio dio = Dio();
    Response response;
    
    // Get the response
    response = await dio.post(
        dexcomUrl.url,
        data: dexcomStatisticsAPIURL.statisticsRequest.toJson(),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'Authorization':
                'Bearer ${GetIt.instance<SharedPreferences>().getString("dexcomAccessToken")}',
          },
        ),
      );

    // Debugging
    final logger = Logger();
    logger.i('$response');

    //Extract data and return them
    List<DexcomStatisticsData> statisticsDataPoints =
        List<DexcomStatisticsData>.empty(growable: true);
    statisticsDataPoints.add(DexcomStatisticsData.fromJson(json: response.data));
    
    return statisticsDataPoints;
  } // fetch

} // DexcomStatisticsDataManager
