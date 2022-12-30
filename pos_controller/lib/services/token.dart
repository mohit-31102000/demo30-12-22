import 'dart:convert';
import 'package:pos_controller/services/api.dart';
import 'package:pos_controller/services/networking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Token {
  static const String _accessTokenPrefKey = 'access_token_pref_key';
  static const String _null = 'NULL';

  static const String _kExpiry = 'expiry';
  static const String _kExpiresIn = 'expires_in';
  static const String _kAccessToken = 'token';

  static Future<dynamic> _fetchToken() async {
    var body = {
      'client_id': 'pos@17052022',
      'client_secret': 'testpass',
      'grant_type': 'client_credentials',
    };
    var jsonResponse = jsonDecode(await Networking.post(Api.kTokenUrl, body));

    String accessToken = jsonResponse['access_token'];
    int expiresIn = jsonResponse['expires_in'];

    return {
      _kAccessToken: accessToken,
      _kExpiresIn: expiresIn,
    };
  }

  static Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String tokenDetails = preferences.getString(_accessTokenPrefKey) ?? _null;

    int current = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    if (tokenDetails != _null) {
      // if token available
      var data = jsonDecode(tokenDetails);
      int expiry = data[_kExpiry];

      // if not expired - send back the stored token
      if (expiry > current) return data[_kAccessToken];
    }

    // need to fetch the token again - either expired or never fetched
    var data = await _fetchToken();

    String token = data[_kAccessToken];
    int expiry = data[_kExpiresIn] + current;

    // save the token for future use
    await preferences.setString(
      _accessTokenPrefKey,
      jsonEncode({
        _kAccessToken: token,
        _kExpiry: expiry,
      }),
    );

    return token;
  }
}
