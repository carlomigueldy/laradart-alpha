import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences _prefs;
  SharedPreferences get prefs => _prefs;

  SharedPreferencesService() {
    initialize();
  }

  Future initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
