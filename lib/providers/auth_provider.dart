import '../config/config.dart';
import '../models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  // Dependency Injections
  SharedPreferences _prefs;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Config.baseUrl,
    headers: {
      "content-type": "application/json",
    },
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  // Instantiate instances
  AuthProvider() {
    initSharedPreferences();
  }

  // State
  User _user;
  String _token = "";

  // Getters
  User get user => _user;
  String get token => _token;
  bool get loggedIn => _token.isNotEmpty ? true : false;
  String get fullName => _user != null ? _user.fullName : "Guest";

  // Mutations
  void setUser(Map<String, dynamic> user) {
    this._user = User.fromJson(user);
    notifyListeners();
  }

  /// Initialize shared prefs
  Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> tryAutoLogin() async {
    print('tryAutoLogin executed');
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('auth.token')) {
      return false;
    }

    // fetchUser(token);
    return true;
  }

  /// Attempts to sign in to API
  Future login(Map<String, String> credentials) async {
    try {
      Response response = await _dio.post('${Config.baseUrl}/api/auth/login',
          data: credentials);
      String token = response.data['access_token'];
      setToken(token);
      fetchUser(token);
      return response;
    } on DioError catch (error) {
      print(error);
      return error.response;
    }
  }

  /// Logs out the user
  Future logout() async {
    try {
      Response response = await _dio.get('${Config.baseUrl}/api/auth/logout',
          options: Options(headers: {"Authorization": "Bearer $_token"}));
      deleteToken();
      return response;
    } on DioError catch (error) {
      print(error);
      return error.response;
    }
  }

  /// Fetch the authenticated user
  Future fetchUser(String token) async {
    try {
      Response response = await _dio.get('${Config.baseUrl}/api/auth/user',
          options:
              Options(headers: {"Authorization": "Bearer ${token ?? _token}"}));
      setUser(response.data);
      return response;
    } on DioError catch (error) {
      print(error.response);
      return error.response;
    }
  }

  /// Get the auth token
  String getToken() {
    String token = _prefs.getString('auth.token') ?? "";
    _token = token;
    notifyListeners();
    return token;
  }

  /// Set the auth token
  Future<void> setToken(String token) async {
    _token = token;
    _prefs.setString('auth.token', token);
    notifyListeners();
  }

  /// Remove the auth token
  Future<void> deleteToken() async {
    _token = "";
    _user = null;
    _prefs.remove('auth.token');
    notifyListeners();
  }
}
