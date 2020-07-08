import 'package:daycare_flutter/config/config.dart';
import 'package:daycare_flutter/models/auth_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  static Dio _dio = Dio(BaseOptions(
    baseUrl: Config.baseUrl,
    headers: {
      "content-type": "application/json",
    },
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  AuthenticatedUser _user;
  AuthenticatedUser get user => _user;

  String _token = "";
  String get token => _token;

  /// Checks if user is logged
  get loggedIn => _token.isNotEmpty ? true : false;

  setUser(user) {
    this._user = AuthenticatedUser.fromJson(user);
    print(this._user.firstName);

    notifyListeners();
  }

  Future login(Map<String, String> credentials) async {
    try {
      Response response = await _dio.post('${Config.baseUrl}/api/auth/login',
          data: credentials);

      setToken(response.data['access_token']);
      fetchUser();
      return response;
    } on DioError catch (error) {
      print(error);
    }
  }

  Future logout() async {
    try {
      Response response = await _dio.get('${Config.baseUrl}/api/auth/logout',
          options: Options(headers: {"Authorization": "Bearer $_token"}));
      deleteToken();
      return response;
    } on DioError catch (error) {
      print(error);
    }
  }

  /// Fetch the authenticated user
  Future<void> fetchUser() async {
    try {
      Response response = await _dio.get('${Config.baseUrl}/api/auth/user',
          options: Options(headers: {"Authorization": "Bearer $_token"}));
      setUser(response.data);
    } on DioError catch (error) {
      print(error.response.statusCode);
    }
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
    _token = "";
    prefs.remove('auth.token');
    notifyListeners();
  }
}
