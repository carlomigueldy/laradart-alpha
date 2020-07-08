import 'package:daycare_flutter/providers/auth_provider.dart';
import 'package:dio/dio.dart';

class AuthService {
  final AuthProvider authProvider = AuthProvider();
  static String _baseUrl = 'http://192.168.1.7';

  Dio get dio {
    BaseOptions options = new BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${authProvider.token}"
      },
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    return Dio(options);
  }

  Future login(Map<String, String> credentials) async {
    try {
      Response response =
          await this.dio.post('$_baseUrl/api/auth/login', data: credentials);

      authProvider.setToken(response.data['access_token']);

      return response;
    } on DioError catch (error) {
      print(error);
    }
  }

  Future getUser() async {
    try {
      Response response = await this.dio.get('$_baseUrl/api/auth/user');
      authProvider.setUser(response.data);
      return response;
    } on DioError catch (error) {
      print(error);
    }
  }
}
