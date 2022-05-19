import 'dart:convert';

import 'package:market_place_flutter_app/entities/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientPreferences {
  static late SharedPreferences _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setClient(Client client) async {
    final json = jsonEncode(client.toJson());
    final token = client.token;
    await _preferences.setString(token, json);
  }

  static Client getClient(String token) {
    final json = _preferences.getString(token);
    return Client.fromJson(jsonDecode(json!));
  }
}
