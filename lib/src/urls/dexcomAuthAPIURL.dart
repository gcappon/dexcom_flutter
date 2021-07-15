import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dexcom_flutter/src/urls/dexcomAPIURL.dart';

/// [DexcomAuthAPIURL] is a class that expresses multiple factory
/// constructors to be used to generate Dexcom Web APIs urls to
/// be used by [DexcomConnector].
class DexcomAuthAPIURL extends DexcomAPIURL {
  /// The data to be attached to the url.
  String? data;

  
  /// Default [DexcomAuthAPIURL] constructor.
  DexcomAuthAPIURL({required String url, required bool isSandbox, String? data}) : super(url : url, isSandbox : isSandbox){

    // DexcomAuthAPIURL fields
    this.data = data;

  } // DexcomAuthAPIURL

  /// Factory constructor that generates a [DexcomAuthAPIURL] to be used
  /// to get to the Dexcom authorization form.
  factory DexcomAuthAPIURL.authorizeForm(
      {required String redirectUri,
      required String clientID,
      required bool isSandbox}) {
    // Encode the redirectUri
    final String encodedRedirectUri = Uri.encodeFull(redirectUri);

    return DexcomAuthAPIURL(
      url:
          '${_getBaseURL(isSandbox)}/login?client_id=$clientID&redirect_uri=$encodedRedirectUri&response_type=code&scope=offline_access&state=0',
      isSandbox: isSandbox,
      data: null,
    );
  } // DexcomAuthAPIURL.authorizeForm

  /// Factory constructor that generates a [DexcomAuthAPIURL] to be used
  /// to get the access and refresh tokens.
  factory DexcomAuthAPIURL.authorize(
      {required String redirectUri,
      required bool isSandbox,
      required String code,
      required String clientID,
      required String clientSecret}) {
    // Encode the redirectUri
    final String encodedRedirectUri = Uri.encodeFull(redirectUri);

    return DexcomAuthAPIURL(
      url: '${_getBaseURL(isSandbox)}/token',
      isSandbox: isSandbox,
      data:
          'client_id=$clientID&client_secret=$clientSecret&grant_type=authorization_code&code=$code&redirect_uri=$encodedRedirectUri',
    );
  } // DexcomAuthAPIURL.authorize

  /// Factory constructor that generates a [DexcomAuthAPIURL] to be used
  /// to refresh the access token.
  factory DexcomAuthAPIURL.refreshToken(
      {required bool isSandbox,
      required String clientID,
      required String clientSecret}) {
    // Encode the redirectUri
    final String encodedRedirectUri = Uri.encodeFull(GetIt.instance<SharedPreferences>().getString('dexcomRedirectUri')!);

    return DexcomAuthAPIURL(
      url: '${_getBaseURL(isSandbox)}/token',
      isSandbox: isSandbox,
      data:
          'client_id=$clientID&client_secret=$clientSecret&grant_type=refresh_token&refresh_token=${GetIt.instance<SharedPreferences>().getString('dexcomRefreshToken')}&redirect_uri=$encodedRedirectUri',
    );
  } // DexcomAuthAPIURL.refreshToken

  /// A private method that generates the base url of a [DexcomAuthAPIURL].
  static String _getBaseURL(bool isSandbox) {
    return isSandbox
        ? 'https://sandbox-api.dexcom.com/v2/oauth2'
        : 'https://api.dexcom.com/v2/oauth2';
  } // _getBaseURL

} // DexcomAuthAPIURL
