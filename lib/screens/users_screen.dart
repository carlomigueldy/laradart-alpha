import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  static const routeName = '/users';

  @override
  Widget build(BuildContext context) {
    // A listener is not needed so we set
    // the listen property to false
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.chevron_left),
            iconSize: 32,
          ),
          title: Text(
            'User Screen',
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Center(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Users Screen'),
                Text(authProvider.fullName)
              ],
            )),
          ),
        ));
  }
}
