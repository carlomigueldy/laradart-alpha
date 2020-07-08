import 'package:daycare_flutter/providers/auth_provider.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  final AuthProvider authProvider;
  List<dynamic> users = [];

  UserProvider({
    this.authProvider,
    this.users,
  });
}
