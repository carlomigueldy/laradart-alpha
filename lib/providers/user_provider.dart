import 'package:flutter/foundation.dart';
import 'package:laradart/models/user.dart';

class UserProvider with ChangeNotifier {
  final String token;
  List<dynamic> users = [];

  UserProvider({
    this.token,
    this.users,
  });

  Future<List<User>> getAllUsers() async {}
}
