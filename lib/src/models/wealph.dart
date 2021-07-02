import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WealphModel extends ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _token = "";

  WealphModel() {
    getToken();
  }

  // saves the token
  Future<void> editToken(String newToken) async {
    _token = await _prefs.then((value) {
      value.setString("OPENWEATHERMAP_API", newToken);
      return newToken;
    });
    notifyListeners();
  }

  Future<void> getToken() async {
    _token = await _prefs.then((value) => value.getString("OPENWEATHERMAP_API") ?? "");
  }

  String get token => _token;
}
