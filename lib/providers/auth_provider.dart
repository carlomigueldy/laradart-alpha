import 'package:daycare_flutter/models/auth_user.dart';
import 'package:daycare_flutter/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  AuthenticatedUser _user;
  AuthenticatedUser get user => _user;

  String _token = "";
  String get token => _token;

  /// Checks if user is logged
  get loggedIn {
    if (_token.isEmpty) {
      return false;
    }

    return true;
  }

  setUser(user) {
    this._user = AuthenticatedUser.fromJson(user);
    print(this._user.firstName);

    notifyListeners();
  }

  /// Set the auth token
  Future<void> setToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    _token = token;
    prefs.setString('auth.token', token);
    notifyListeners();
  }

  /// Remove the auth token
  Future<void> deleteToken() async {
    final SharedPreferences prefs = await _prefs;
    _token = null;
    prefs.remove('auth.token');
    notifyListeners();
  }
}
