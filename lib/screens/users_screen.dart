import 'package:daycare_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  static const routeName = '/users';

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('User Screen'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: Text(userProvider.token),
          ),
        ));
  }
}
