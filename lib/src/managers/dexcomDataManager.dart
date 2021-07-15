import 'dart:convert';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

import 'package:dexcom_flutter/src/exceptions/exceptions.dart';

import 'package:dexcom_flutter/src/data/dexcomData.dart';

import 'package:dexcom_flutter/src/dexcomConnector.dart';

/// [DexcomDataManager] is an abstract class the manages the requests related to
/// [DexcomData].
abstract class DexcomDataManager {
  /// The client id.
  String? clientID;

  /// The client secret id.
  String? clientSecret;

  /// Default constructor
  DexcomDataManager({this.clientID, this.clientSecret});

  /// Method that fetches data from the Dexcom API.
  Future<List<DexcomData>> fetch(DexcomAPIURL url);

  /// Method the obtains the response from the given [DexcomAPIURL].
  Future<dynamic> getResponse(DexcomAPIURL dexcomAPIUrl) async {

    // Refresh token if needed
    if(DexcomConnector.tokenNeedRefresh()){
      await DexcomConnector.refreshToken(clientID: clientID!, clientSecret: clientSecret!, isSandbox: dexcomAPIUrl.isSandbox);
    }//if

    // Instantiate Dio and its Response
    Dio dio = Dio();
    late Response response;

    try {
      // get the Dexcom data
      response = await dio.get(
        dexcomAPIUrl.url,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization':
                'Bearer ${GetIt.instance<SharedPreferences>().getString("dexcomAccessToken")}',
          },
        ),
      );
    } on DioError catch (e) {
      DexcomDataManager.manageError(e);
    } // try - catch

    final decodedResponse =
        response.data is String ? jsonDecode(response.data) : response.data;

    Future<dynamic> ret = Future.value(decodedResponse);
    return ret;
  } //getResponse

  /// Method that manages errors that could return from the Dexcom API.
  static void manageError(DioError e) {
    switch (e.response!.statusCode) {
      case 200:
        break;
      case 302:
        throw DexcomFoundException(message: "");
      case 400:
        throw DexcomBadRequestException(message: "");
      case 401:
        throw DexcomUnauthorizedException(message: "");
      case 404:
        throw DexcomNotFoundException(message: "");
      case 429:
        throw DexcomTooManyRequestsException(message: "");
      case 500:
        throw DexcomInternalServerErrorException(message: "");
    } // switch
  } // manageError

} // DexcomDataManager
