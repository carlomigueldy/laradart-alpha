import 'package:daycare_flutter/providers/auth_provider.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  final String token;
  List<dynamic> users = [];

  UserProvider({
    this.token,
    this.users,
  });
}
