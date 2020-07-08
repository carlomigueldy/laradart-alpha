import 'package:daycare_flutter/config/config.dart';
import 'package:daycare_flutter/models/auth_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  static Dio _dio;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  AuthenticatedUser _user;
  AuthenticatedUser get user => _user;

  String _token = "";
  String get token => _token;

  AuthProvider() {
    _dio = Dio(BaseOptions(
      baseUrl: Config.baseUrl,
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer $_token"
      },
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ));
  }

  /// Checks if user is logged
  get loggedIn => _token != null ? true : false;

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

  Future getUser() async {
    try {
      Response response = await _dio.get('${Config.baseUrl}/api/auth/user');
      setUser(response.data);
      print('== getUser ==');
      return response;
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
    _token = null;
    prefs.remove('auth.token');
    notifyListeners();
  }
}
