import 'dart:async';

import 'package:dexcom_flutter/src/utils/formats.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dexcom_flutter/src/urls/dexcomAuthAPIURL.dart';

/// [DexcomConnector] is a class that is in charge of managing the connection authorization
///  between the app and Dexcom APIs.
/// In details, it can authorize the app thus retaining the access and refresh tokens (see
/// [DexcomConnector.authorize] for more details), refresh the access token if needed (see
/// [DexcomConnector.refreshToken] for more details), unauthorize the app (see
/// [DexcomConnector.unauthorize] for more details), and check for the access token status
/// (see [DexcomConnector.isTokenValid] for more details).

class DexcomConnector {
  /// [DexcomConnector] Singleton instance.
  static final DexcomConnector _instance = DexcomConnector._internal();

  /// Public factory constructor of [DexcomConector].
  factory DexcomConnector() => _instance;

  /// [DexcomConnector] internal constructor used to implement the Singleton pattern.
  DexcomConnector._internal();

  /// Method that refreshes the Dexcom access token.
  static Future<bool> refreshToken(
      {BuildContext? context,
      required String clientID,
      required String clientSecret,
      required bool isSandbox}) async {
    // Instantiate Dio and its Response
    Dio dio = Dio();
    Response response;

    // Generate the Dexcom url
    final dexcomAuthorizeUrl = DexcomAuthAPIURL.refreshToken(
          clientID: clientID,
          clientSecret: clientSecret,
          isSandbox: isSandbox);

      response = await dio.post(
        dexcomAuthorizeUrl.url,
        data: dexcomAuthorizeUrl.data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

    // Debugging
    final logger = Logger();
    logger.i('$response');

    // Overwrite the tokens into the shared preferences
    final accessToken = response.data['access_token'] as String;
    final refreshToken = response.data['refresh_token'] as String;
    final expires = response.data['expires_in'] as int;

    GetIt.instance<SharedPreferences>()
        .setString('dexcomAccessToken', accessToken);
    GetIt.instance<SharedPreferences>()
        .setString('dexcomRefreshToken', refreshToken);
    GetIt.instance<SharedPreferences>()
          .setString('dexcomTokenExpires', Formats.fullDateFormat.format(DateTime.now().add(Duration(seconds: expires))));

    return true;
  } // refreshToken

  /// Method that implements the OAuth 2.0 protocol and gets (and retain)
  /// in the [SharedPreferences] the access and refresh tokens from Dexcom APIs.
  static Future<bool> authorize(
      {BuildContext? context,
      required String clientID,
      required String clientSecret,
      required String redirectUri,
      required String callbackUrlScheme,
      required bool isSandbox}) async {
    // Instantiate Dio and its Response
    Dio dio = Dio();
    Response response;

    // Generate the Dexcom url
    final dexcomAuthorizeFormUrl = DexcomAuthAPIURL.authorizeForm(
        redirectUri: redirectUri, clientID: clientID, isSandbox: isSandbox);

    // Perform authentication
    try {
      final result = await FlutterWebAuth.authenticate(
          url: dexcomAuthorizeFormUrl.url,
          callbackUrlScheme: callbackUrlScheme);
      //Get the auth code
      final code = Uri.parse(result).queryParameters['code'];

      // Generate the Dexcom url
      final dexcomAuthorizeUrl = DexcomAuthAPIURL.authorize(
          redirectUri: redirectUri,
          code: code!,
          clientID: clientID,
          clientSecret: clientSecret,
          isSandbox: isSandbox);

      response = await dio.post(
        dexcomAuthorizeUrl.url,
        data: dexcomAuthorizeUrl.data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      // Debugging
      final logger = Logger();
      logger.i('$response');

      // Save authorization tokens
      final accessToken = response.data['access_token'] as String;
      final refreshToken = response.data['refresh_token'] as String;
      final expires = response.data['expires_in'] as int;

      GetIt.instance<SharedPreferences>()
          .setString('dexcomAccessToken', accessToken);
      GetIt.instance<SharedPreferences>()
          .setString('dexcomRefreshToken', refreshToken);
      GetIt.instance<SharedPreferences>()
          .setString('dexcomTokenExpires', Formats.fullDateFormat.format(DateTime.now().add(Duration(seconds: expires))));
      GetIt.instance<SharedPreferences>()
          .setString('dexcomRedirectUri', redirectUri);
    } catch (e) {
      print(e);
    } // catch

    return true;
  } // authorize

  /// Method that revokes the current access, refreshes tokens and
  /// deletes them from the [SharedPreferences].
  static Future<void> unauthorize() async {

      // Remove the tokens from shared preferences
      GetIt.instance<SharedPreferences>().remove('dexcomAccessToken');
      GetIt.instance<SharedPreferences>().remove('dexcomRefreshToken');
      GetIt.instance<SharedPreferences>().remove('dexcomTokenExpires');
      GetIt.instance<SharedPreferences>().remove('dexcomRedirectUri');

      // Debugging
      final logger = Logger();
      logger.i('Tokens deleted successfully.');

  } // unauthorize

  /// Method that checks if the Dexcom access_token needs to be refreshed.
  static bool tokenNeedRefresh() {
    
    DateTime expiration = Formats.fullDateFormat.parse(GetIt.instance<SharedPreferences>().getString('dexcomTokenExpires')!);

    bool ret = DateTime.now().isAfter(expiration);

    // Debugging
    final logger = Logger();
    logger.i('Tokens is ${ret? 'not' : ''} valid.');

    return ret;

  } // tokenNeedRefresh

} // DexcomConnector
