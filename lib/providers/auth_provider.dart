import '../config/config.dart';
import '../models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final String _authToken = 'auth.token';

  // Dependency Injections
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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
    initialize();
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
    _user = User.fromJson(user);
    notifyListeners();
  }

  /// Initialize shared prefs
  Future<void> initialize() async {
    await getToken();
  }

  Future<bool> tryAutoLogin() async {
    print('tryAutoLogin executed');
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey(_authToken)) {
      print('tryAutoLogin() says no token');
      return false;
    }

    await getToken();
    await fetchUser();

    return true;
  }

  /// Attempts to sign in to API
  Future login(Map<String, String> credentials) async {
    try {
      Response response = await _dio.post('${Config.baseUrl}/api/auth/login',
          data: credentials);
      String token = response.data['access_token'];
      await setToken(token);
      await fetchUser();
      return response;
    } on DioError catch (error) {
      handleError(error);
      return error.response;
    }
  }

  /// Logs out the user
  Future logout() async {
    try {
      Response response = await _dio.get('${Config.baseUrl}/api/auth/logout',
          options: Options(headers: {
            "Authorization": "Bearer ${_token ?? await getToken()}"
          }));
      deleteToken();
      return response;
    } on DioError catch (error) {
      handleError(error);
      return error.response;
    }
  }

  /// Fetch the authenticated user
  Future fetchUser() async {
    try {
      print('executed fetchUser()');
      Response response = await _dio.get('${Config.baseUrl}/api/auth/user',
          options: Options(headers: {"Authorization": "Bearer $_token"}));
      setUser(response.data);
      return response;
    } on DioError catch (error) {
      handleError(error);
      return error.response;
    }
  }

  /// Get the auth token
  Future<String> getToken() async {
    final SharedPreferences prefs = await _prefs;

    String token = prefs.getString(_authToken) ?? "";
    _token = token;
    notifyListeners();
    return token;
  }

  /// Set the auth token
  Future<void> setToken(String token) async {
    final SharedPreferences prefs = await _prefs;

    _token = token;
    prefs.setString(_authToken, token);

    notifyListeners();
  }

  /// Remove the auth token
  Future<void> deleteToken() async {
    final SharedPreferences prefs = await _prefs;
    _token = "";
    _user = null;
    prefs.remove(_authToken);
    notifyListeners();
  }

  /// HTTP error handler
  handleError(DioError error) {
    print(error);
    switch (error.response.statusCode) {
      case 403:
        deleteToken();
        break;
      case 401:
        deleteToken();
        break;
      default:
        print('An unknown error has occurred, $error');
    }
  }
}
